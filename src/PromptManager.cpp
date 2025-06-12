#include "PromptManager.h"
#include "DatabaseManager.h"
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>
#include <QFile>
#include <QTextStream>
#include <QDebug>
#include <QUuid>
#include <algorithm>

PromptManager::PromptManager(DatabaseManager *dbManager, QObject *parent)
    : QAbstractListModel(parent)
    , m_dbManager(dbManager)
{
    connect(m_dbManager, &DatabaseManager::promptsChanged,
            this, &PromptManager::loadPrompts);
    
    // Load prompts on initialization
    loadPrompts();
}

PromptManager::~PromptManager() = default;

int PromptManager::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return static_cast<int>(m_prompts.size());
}

QVariant PromptManager::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= static_cast<int>(m_prompts.size())) {
        return QVariant();
    }
    
    const Prompt &prompt = m_prompts[index.row()];
    
    switch (role) {
    case IdRole:
        return prompt.id;
    case NameRole:
        return prompt.name;
    case ContentRole:
        return prompt.content;
    case CategoryRole:
        return prompt.category;
    case IsActiveRole:
        return prompt.isActive;
    case CreatedAtRole:
        return prompt.createdAt;
    case ModifiedAtRole:
        return prompt.modifiedAt;
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> PromptManager::roleNames() const
{
    QHash<int, QByteArray> names;
    names[IdRole] = "promptId";
    names[NameRole] = "name";
    names[ContentRole] = "content";
    names[CategoryRole] = "category";
    names[IsActiveRole] = "isActive";
    names[CreatedAtRole] = "createdAt";
    names[ModifiedAtRole] = "modifiedAt";
    return names;
}

void PromptManager::setActivePromptId(const QString &id)
{
    if (m_activePromptId != id) {
        // Deactivate previous prompt
        for (auto &prompt : m_prompts) {
            if (prompt.isActive) {
                prompt.isActive = false;
                QJsonObject json = promptToJson(prompt);
                m_dbManager->updatePrompt(prompt.id, json);
            }
        }
        
        // Activate new prompt
        for (auto &prompt : m_prompts) {
            if (prompt.id == id) {
                prompt.isActive = true;
                QJsonObject json = promptToJson(prompt);
                m_dbManager->updatePrompt(prompt.id, json);
                break;
            }
        }
        
        m_activePromptId = id;
        emit activePromptIdChanged();
        refreshPrompts();
    }
}

QString PromptManager::getActivePromptContent() const
{
    auto it = std::find_if(m_prompts.begin(), m_prompts.end(),
                          [](const Prompt &p) { return p.isActive; });
    
    if (it != m_prompts.end()) {
        return it->content;
    }
    
    return QString();
}

QStringList PromptManager::getCategories() const
{
    QStringList categories;
    for (const auto &prompt : m_prompts) {
        if (!categories.contains(prompt.category)) {
            categories.append(prompt.category);
        }
    }
    categories.sort();
    return categories;
}

void PromptManager::loadPrompts()
{
    refreshPrompts();
}

void PromptManager::createPrompt(const QString &name, const QString &content, const QString &category)
{
    Prompt prompt;
    prompt.id = generatePromptId();
    prompt.name = name;
    prompt.content = content;
    prompt.category = category.isEmpty() ? "General" : category;
    prompt.isActive = false;
    prompt.createdAt = QDateTime::currentDateTime();
    prompt.modifiedAt = QDateTime::currentDateTime();
    
    QJsonObject json = promptToJson(prompt);
    if (m_dbManager->addPrompt(json)) {
        refreshPrompts();
        emit promptCreated(prompt.id);
    } else {
        emit error("Failed to create prompt");
    }
}

void PromptManager::updatePrompt(const QString &id, const QString &name, const QString &content, const QString &category)
{
    auto it = std::find_if(m_prompts.begin(), m_prompts.end(),
                          [&id](const Prompt &p) { return p.id == id; });
    
    if (it != m_prompts.end()) {
        it->name = name;
        it->content = content;
        it->category = category;
        it->modifiedAt = QDateTime::currentDateTime();
        
        QJsonObject json = promptToJson(*it);
        if (m_dbManager->updatePrompt(id, json)) {
            int index = std::distance(m_prompts.begin(), it);
            emit dataChanged(createIndex(index, 0), createIndex(index, 0));
            emit promptUpdated(id);
        } else {
            emit error("Failed to update prompt");
        }
    }
}

void PromptManager::deletePrompt(const QString &id)
{
    if (m_dbManager->deletePrompt(id)) {
        refreshPrompts();
        emit promptDeleted(id);
    } else {
        emit error("Failed to delete prompt");
    }
}

void PromptManager::activatePrompt(const QString &id)
{
    setActivePromptId(id);
}

void PromptManager::importPrompts(const QString &filePath)
{
    QFile file(filePath);
    if (!file.open(QIODevice::ReadOnly)) {
        emit error("Failed to open import file: " + file.errorString());
        return;
    }
    
    QJsonDocument doc = QJsonDocument::fromJson(file.readAll());
    file.close();
    
    if (doc.isNull() || !doc.isArray()) {
        emit error("Invalid import file format");
        return;
    }
    
    QJsonArray prompts = doc.array();
    int imported = 0;
    
    for (const auto &value : prompts) {
        QJsonObject promptJson = value.toObject();
        promptJson["id"] = generatePromptId(); // Generate new ID to avoid conflicts
        promptJson["createdAt"] = QDateTime::currentDateTime().toString(Qt::ISODate);
        promptJson["modifiedAt"] = QDateTime::currentDateTime().toString(Qt::ISODate);
        promptJson["isActive"] = false;
        
        if (m_dbManager->addPrompt(promptJson)) {
            imported++;
        }
    }
    
    refreshPrompts();
    qDebug() << "Imported" << imported << "prompts";
}

void PromptManager::exportPrompts(const QString &filePath)
{
    QJsonArray prompts;
    
    for (const auto &prompt : m_prompts) {
        QJsonObject json = promptToJson(prompt);
        prompts.append(json);
    }
    
    QJsonDocument doc(prompts);
    
    QFile file(filePath);
    if (file.open(QIODevice::WriteOnly)) {
        file.write(doc.toJson(QJsonDocument::Indented));
        file.close();
        qDebug() << "Exported" << prompts.size() << "prompts";
    } else {
        emit error("Failed to export prompts: " + file.errorString());
    }
}

void PromptManager::refreshPrompts()
{
    beginResetModel();
    
    m_prompts.clear();
    QJsonArray promptsArray = m_dbManager->getAllPrompts();
    
    for (const auto &value : promptsArray) {
        QJsonObject json = value.toObject();
        Prompt prompt = jsonToPrompt(json);
        m_prompts.push_back(prompt);
        
        if (prompt.isActive) {
            m_activePromptId = prompt.id;
        }
    }
    
    endResetModel();
    emit promptCountChanged();
}

Prompt PromptManager::jsonToPrompt(const QJsonObject &json) const
{
    Prompt prompt;
    prompt.id = json["id"].toString();
    prompt.name = json["name"].toString();
    prompt.content = json["content"].toString();
    prompt.category = json["category"].toString();
    prompt.isActive = json["isActive"].toBool();
    prompt.createdAt = QDateTime::fromString(json["createdAt"].toString(), Qt::ISODate);
    prompt.modifiedAt = QDateTime::fromString(json["modifiedAt"].toString(), Qt::ISODate);
    return prompt;
}

QJsonObject PromptManager::promptToJson(const Prompt &prompt) const
{
    QJsonObject json;
    json["id"] = prompt.id;
    json["name"] = prompt.name;
    json["content"] = prompt.content;
    json["category"] = prompt.category;
    json["isActive"] = prompt.isActive;
    json["createdAt"] = prompt.createdAt.toString(Qt::ISODate);
    json["modifiedAt"] = prompt.modifiedAt.toString(Qt::ISODate);
    return json;
}

QString PromptManager::generatePromptId() const
{
    return QUuid::createUuid().toString(QUuid::WithoutBraces);
} 