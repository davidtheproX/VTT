#ifndef LLMCONNECTIONMANAGER_H
#define LLMCONNECTIONMANAGER_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QJsonObject>
#include <QUrl>
#include <memory>

class LLMConnectionManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(Provider currentProvider READ currentProvider WRITE setCurrentProvider NOTIFY currentProviderChanged)
    Q_PROPERTY(bool isConnected READ isConnected NOTIFY isConnectedChanged)
    Q_PROPERTY(QString apiKey READ apiKey WRITE setApiKey NOTIFY apiKeyChanged)
    Q_PROPERTY(QString baseUrl READ baseUrl WRITE setBaseUrl NOTIFY baseUrlChanged)
    Q_PROPERTY(QString model READ model WRITE setModel NOTIFY modelChanged)

public:
    enum Provider {
        OpenAI,
        LMStudio,
        Ollama
    };
    Q_ENUM(Provider)

    explicit LLMConnectionManager(QObject *parent = nullptr);
    ~LLMConnectionManager();

    Provider currentProvider() const { return m_currentProvider; }
    void setCurrentProvider(Provider provider);

    bool isConnected() const { return m_isConnected; }
    void setConnectionStatus(bool connected);
    
    QString apiKey() const { return m_apiKey; }
    void setApiKey(const QString &key);
    
    QString baseUrl() const { return m_baseUrl; }
    void setBaseUrl(const QString &url);
    
    QString model() const { return m_model; }
    void setModel(const QString &model);

public slots:
    void sendMessage(const QString &message, const QString &systemPrompt = QString());
    void testConnection();
    void cancelRequest();

signals:
    void responseReceived(const QString &response);
    void streamingResponseUpdate(const QString &partialResponse);
    void error(const QString &errorMessage);
    void currentProviderChanged();
    void isConnectedChanged();
    void apiKeyChanged();
    void baseUrlChanged();
    void modelChanged();
    void requestStarted();
    void requestFinished();

private slots:
    void handleNetworkReply();
    void handleTestConnectionReply();

private:
    void sendOpenAIRequest(const QString &message, const QString &systemPrompt);
    void sendLMStudioRequest(const QString &message, const QString &systemPrompt);
    void sendOllamaRequest(const QString &message, const QString &systemPrompt);
    
    void testOpenAIConnection();
    void testLMStudioConnection();
    void testOllamaConnection();
    
    void connectReplySignals(bool isTestConnection);
    
    QJsonObject createRequestBody(const QString &message, const QString &systemPrompt);
    QString getEndpointUrl() const;
    int getTimeoutForOperation(bool isTestConnection) const;

    Provider m_currentProvider;
    bool m_isConnected;
    bool m_isTestingConnection;
    QString m_apiKey;
    QString m_baseUrl;
    QString m_model;
    
    std::unique_ptr<QNetworkAccessManager> m_networkManager;
    QNetworkReply *m_currentReply = nullptr;
};

#endif // LLMCONNECTIONMANAGER_H 