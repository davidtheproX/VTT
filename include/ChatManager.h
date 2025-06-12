#ifndef CHATMANAGER_H
#define CHATMANAGER_H

#include <QObject>
#include <QAbstractListModel>
#include <QDateTime>
#include <QtQmlIntegration>
#include <vector>
#include <memory>

class LLMConnectionManager;
class DatabaseManager;
class TTSManager;

struct Message {
    enum Role {
        User,
        Assistant,
        System
    };
    
    QString id;
    QString content;
    Role role;
    QDateTime timestamp;
    bool isStreaming = false;
};

class ChatManager : public QAbstractListModel
{
    Q_OBJECT
    QML_ELEMENT
    Q_PROPERTY(bool isProcessing READ isProcessing NOTIFY isProcessingChanged)
    Q_PROPERTY(int messageCount READ messageCount NOTIFY messageCountChanged)
    Q_PROPERTY(QString currentSystemPrompt READ currentSystemPrompt WRITE setCurrentSystemPrompt NOTIFY currentSystemPromptChanged)

public:
    enum ChatRoles {
        ContentRole = Qt::UserRole + 1,
        RoleRole,
        TimestampRole,
        IsStreamingRole,
        IdRole
    };

    explicit ChatManager(LLMConnectionManager *llmManager, QObject *parent = nullptr);
    void setDatabaseManager(DatabaseManager *dbManager);
    void setTTSManager(TTSManager *ttsManager);
    ~ChatManager();

    // QAbstractListModel interface
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    bool isProcessing() const { return m_isProcessing; }
    int messageCount() const { return static_cast<int>(m_messages.size()); }
    QString currentSystemPrompt() const { return m_currentSystemPrompt; }
    void setCurrentSystemPrompt(const QString &prompt);

public slots:
    void processUserInput(const QString &text);
    void clearChat();
    void regenerateLastResponse();
    void deleteMessage(const QString &messageId);
    void editMessage(const QString &messageId, const QString &newContent);
    void exportChat(const QString &filePath);
    void importChat(const QString &filePath);
    bool writeTextFile(const QString &filePath, const QString &content);

signals:
    void isProcessingChanged();
    void messageCountChanged();
    void currentSystemPromptChanged();
    void messageAdded(const QString &messageId);
    void messageUpdated(const QString &messageId);
    void error(const QString &errorMessage);

private slots:
    void handleLLMResponse(const QString &response);
    void handleStreamingUpdate(const QString &partialResponse);
    void handleLLMError(const QString &error);

private:
    void addMessage(const QString &content, Message::Role role);
    void updateStreamingMessage(const QString &content);
    QString generateMessageId() const;
    QString buildCombinedSystemPrompt() const;
    
    std::vector<Message> m_messages;
    LLMConnectionManager *m_llmManager;
    DatabaseManager *m_databaseManager;
    TTSManager *m_ttsManager;
    bool m_isProcessing;
    QString m_currentSystemPrompt;
    QString m_currentStreamingId;
};

#endif // CHATMANAGER_H 