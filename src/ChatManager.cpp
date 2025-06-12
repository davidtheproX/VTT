#include "ChatManager.h"
#include "LLMConnectionManager.h"
#include "DatabaseManager.h"
#include "TTSManager.h"
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>
#include <QFile>
#include <QTextStream>
#include <QDebug>
#include <QUuid>

ChatManager::ChatManager(LLMConnectionManager *llmManager, QObject *parent)
    : QAbstractListModel(parent)
    , m_llmManager(llmManager)
    , m_databaseManager(nullptr)
    , m_ttsManager(nullptr)
    , m_isProcessing(false)
{
    // Connect to LLM manager signals
    connect(m_llmManager, &LLMConnectionManager::responseReceived,
            this, &ChatManager::handleLLMResponse);
    connect(m_llmManager, &LLMConnectionManager::streamingResponseUpdate,
            this, &ChatManager::handleStreamingUpdate);
    connect(m_llmManager, &LLMConnectionManager::error,
            this, &ChatManager::handleLLMError);
    connect(m_llmManager, &LLMConnectionManager::requestStarted,
            this, [this]() {
                m_isProcessing = true;
                emit isProcessingChanged();
            });
    connect(m_llmManager, &LLMConnectionManager::requestFinished,
            this, [this]() {
                m_isProcessing = false;
                
                // Clear any leftover streaming state when request finishes
                if (!m_currentStreamingId.isEmpty()) {
                    qDebug() << "Clearing leftover streaming ID on request finish";
                    m_currentStreamingId.clear();
                }
                
                emit isProcessingChanged();
            });
}

ChatManager::~ChatManager() = default;

void ChatManager::setDatabaseManager(DatabaseManager *dbManager)
{
    m_databaseManager = dbManager;
}

void ChatManager::setTTSManager(TTSManager *ttsManager)
{
    m_ttsManager = ttsManager;
}

int ChatManager::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return static_cast<int>(m_messages.size());
}

QVariant ChatManager::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= static_cast<int>(m_messages.size())) {
        return QVariant();
    }
    
    const Message &message = m_messages[index.row()];
    
    switch (role) {
    case ContentRole:
        return message.content;
    case RoleRole:
        return static_cast<int>(message.role);
    case TimestampRole:
        return message.timestamp;
    case IsStreamingRole:
        return message.isStreaming;
    case IdRole:
        return message.id;
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> ChatManager::roleNames() const
{
    QHash<int, QByteArray> names;
    names[ContentRole] = "content";
    names[RoleRole] = "role";
    names[TimestampRole] = "timestamp";
    names[IsStreamingRole] = "isStreaming";
    names[IdRole] = "messageId";
    return names;
}

void ChatManager::setCurrentSystemPrompt(const QString &prompt)
{
    if (m_currentSystemPrompt != prompt) {
        m_currentSystemPrompt = prompt;
        emit currentSystemPromptChanged();
    }
}

void ChatManager::processUserInput(const QString &text)
{
    if (text.isEmpty() || m_isProcessing) {
        return;
    }
    
    // Add user message
    addMessage(text, Message::User);
    
    // Build combined system prompt from active prompts
    QString combinedSystemPrompt = buildCombinedSystemPrompt();
    
    // Send to LLM
    m_llmManager->sendMessage(text, combinedSystemPrompt);
}

void ChatManager::clearChat()
{
    beginResetModel();
    m_messages.clear();
    endResetModel();
    emit messageCountChanged();
}

void ChatManager::regenerateLastResponse()
{
    if (m_messages.empty() || m_isProcessing) {
        return;
    }
    
    // Find last user message
    QString lastUserMessage;
    int lastAssistantIndex = -1;
    
    for (int i = static_cast<int>(m_messages.size()) - 1; i >= 0; --i) {
        if (m_messages[i].role == Message::Assistant) {
            lastAssistantIndex = i;
        } else if (m_messages[i].role == Message::User && lastUserMessage.isEmpty()) {
            lastUserMessage = m_messages[i].content;
        }
    }
    
    if (lastUserMessage.isEmpty()) {
        return;
    }
    
    // Remove last assistant message if exists
    if (lastAssistantIndex >= 0) {
        beginRemoveRows(QModelIndex(), lastAssistantIndex, lastAssistantIndex);
        m_messages.erase(m_messages.begin() + lastAssistantIndex);
        endRemoveRows();
        emit messageCountChanged();
    }
    
    // Resend to LLM
    m_llmManager->sendMessage(lastUserMessage, m_currentSystemPrompt);
}

void ChatManager::deleteMessage(const QString &messageId)
{
    auto it = std::find_if(m_messages.begin(), m_messages.end(),
                          [&messageId](const Message &msg) {
                              return msg.id == messageId;
                          });
    
    if (it != m_messages.end()) {
        int index = std::distance(m_messages.begin(), it);
        beginRemoveRows(QModelIndex(), index, index);
        m_messages.erase(it);
        endRemoveRows();
        emit messageCountChanged();
    }
}

void ChatManager::editMessage(const QString &messageId, const QString &newContent)
{
    auto it = std::find_if(m_messages.begin(), m_messages.end(),
                          [&messageId](const Message &msg) {
                              return msg.id == messageId;
                          });
    
    if (it != m_messages.end()) {
        it->content = newContent;
        int index = std::distance(m_messages.begin(), it);
        emit dataChanged(createIndex(index, 0), createIndex(index, 0));
        emit messageUpdated(messageId);
    }
}

void ChatManager::exportChat(const QString &filePath)
{
    QJsonArray messagesArray;
    
    for (const auto &msg : m_messages) {
        QJsonObject msgObj;
        msgObj["id"] = msg.id;
        msgObj["content"] = msg.content;
        msgObj["role"] = static_cast<int>(msg.role);
        msgObj["timestamp"] = msg.timestamp.toString(Qt::ISODate);
        messagesArray.append(msgObj);
    }
    
    QJsonObject root;
    root["messages"] = messagesArray;
    root["systemPrompt"] = m_currentSystemPrompt;
    
    QJsonDocument doc(root);
    
    QFile file(filePath);
    if (file.open(QIODevice::WriteOnly)) {
        file.write(doc.toJson());
        file.close();
    } else {
        emit error("Failed to export chat: " + file.errorString());
    }
}

void ChatManager::importChat(const QString &filePath)
{
    QFile file(filePath);
    if (!file.open(QIODevice::ReadOnly)) {
        emit error("Failed to import chat: " + file.errorString());
        return;
    }
    
    QJsonDocument doc = QJsonDocument::fromJson(file.readAll());
    file.close();
    
    if (doc.isNull()) {
        emit error("Invalid chat file format");
        return;
    }
    
    QJsonObject root = doc.object();
    QJsonArray messagesArray = root["messages"].toArray();
    
    clearChat();
    
    beginResetModel();
    for (const auto &value : messagesArray) {
        QJsonObject msgObj = value.toObject();
        Message msg;
        msg.id = msgObj["id"].toString();
        msg.content = msgObj["content"].toString();
        msg.role = static_cast<Message::Role>(msgObj["role"].toInt());
        msg.timestamp = QDateTime::fromString(msgObj["timestamp"].toString(), Qt::ISODate);
        m_messages.push_back(msg);
    }
    endResetModel();
    
    setCurrentSystemPrompt(root["systemPrompt"].toString());
    emit messageCountChanged();
}

void ChatManager::handleLLMResponse(const QString &response)
{
    qDebug() << "Handling LLM response, length:" << response.length();
    qDebug() << "Current streaming ID:" << m_currentStreamingId;
    qDebug() << "Is processing:" << m_isProcessing;
    
    if (m_currentStreamingId.isEmpty()) {
        // No streaming in progress, add new message
        qDebug() << "Adding new assistant message to chat";
        addMessage(response, Message::Assistant);
    } else {
        // Finalize streaming message by updating its content
        qDebug() << "Finalizing streaming message";
        updateStreamingMessage(response);
        
        // Mark streaming as complete
        auto it = std::find_if(m_messages.begin(), m_messages.end(),
                              [this](const Message &msg) {
                                  return msg.id == m_currentStreamingId;
                              });
        
        if (it != m_messages.end()) {
            it->isStreaming = false;
            int index = std::distance(m_messages.begin(), it);
            emit dataChanged(createIndex(index, 0), createIndex(index, 0));
        }
        
        // Clear streaming ID
        m_currentStreamingId.clear();
    }
    
    // Speak the response if TTS is enabled
    if (m_ttsManager && m_ttsManager->isEnabled()) {
        qDebug() << "Starting TTS for response";
        m_ttsManager->speak(response);
    } else {
        qDebug() << "TTS not enabled or manager not available";
    }
    
    qDebug() << "LLM response handling complete. Total messages:" << m_messages.size();
}

void ChatManager::handleStreamingUpdate(const QString &partialResponse)
{
    updateStreamingMessage(partialResponse);
}

void ChatManager::handleLLMError(const QString &error)
{
    emit this->error(error);
}

void ChatManager::addMessage(const QString &content, Message::Role role)
{
    Message msg;
    msg.id = generateMessageId();
    msg.content = content;
    msg.role = role;
    msg.timestamp = QDateTime::currentDateTime();
    
    // Only mark as streaming if we're actively processing AND this is the start of a streaming response
    // For completed responses (like from handleLLMResponse), don't mark as streaming
    msg.isStreaming = false;  // Default to false for completed messages
    
    qDebug() << QString("Adding message - Role: %1, Content: %2, Streaming: %3")
                .arg(role == Message::User ? "User" : "Assistant")
                .arg(content.left(50) + (content.length() > 50 ? "..." : ""))
                .arg(msg.isStreaming);
    
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_messages.push_back(msg);
    endInsertRows();
    
    emit messageCountChanged();
    emit messageAdded(msg.id);
}

void ChatManager::updateStreamingMessage(const QString &content)
{
    if (m_currentStreamingId.isEmpty()) {
        addMessage(content, Message::Assistant);
        return;
    }
    
    auto it = std::find_if(m_messages.begin(), m_messages.end(),
                          [this](const Message &msg) {
                              return msg.id == m_currentStreamingId;
                          });
    
    if (it != m_messages.end()) {
        it->content = content;
        int index = std::distance(m_messages.begin(), it);
        emit dataChanged(createIndex(index, 0), createIndex(index, 0));
    }
}

QString ChatManager::generateMessageId() const
{
    return QUuid::createUuid().toString(QUuid::WithoutBraces);
}

QString ChatManager::buildCombinedSystemPrompt() const
{
    QStringList activePrompts;
    
    // Always include the current system prompt if set
    if (!m_currentSystemPrompt.isEmpty()) {
        activePrompts.append(m_currentSystemPrompt);
    }
    
    // Add active prompts from database if database manager is available
    if (m_databaseManager) {
        QJsonArray allPrompts = m_databaseManager->getAllPrompts();
        for (const auto &value : allPrompts) {
            QJsonObject prompt = value.toObject();
            bool isActive = prompt["isActive"].toBool();
            QString content = prompt["content"].toString();
            
            if (isActive && !content.isEmpty()) {
                activePrompts.append(content);
            }
        }
    }
    
    // Combine all active prompts
    if (activePrompts.isEmpty()) {
        return QString();
    }
    
    // Join prompts with clear separators
    return activePrompts.join("\n\n---\n\n");
}

bool ChatManager::writeTextFile(const QString &filePath, const QString &content)
{
    QFile file(filePath);
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text)) {
        qWarning() << "Failed to open file for writing:" << filePath << file.errorString();
        return false;
    }
    
    QTextStream stream(&file);
    stream.setEncoding(QStringConverter::Utf8);
    stream << content;
    file.close();
    
    if (file.error() != QFile::NoError) {
        qWarning() << "Error writing to file:" << filePath << file.errorString();
        return false;
    }
    
    qDebug() << "Successfully wrote text file:" << filePath;
    return true;
} 