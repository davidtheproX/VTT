#include "LLMConnectionManager.h"
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonArray>
#include <QDebug>
#include <QTimer>

LLMConnectionManager::LLMConnectionManager(QObject *parent)
    : QObject(parent)
    , m_currentProvider(OpenAI)
    , m_isConnected(false)
    , m_isTestingConnection(false)
    , m_model("gpt-3.5-turbo")
{
    m_networkManager = std::make_unique<QNetworkAccessManager>(this);
    
    // Default URLs for different providers
    m_baseUrl = "https://api.openai.com/v1";
    
    qDebug() << "LLMConnectionManager initialized";
}

LLMConnectionManager::~LLMConnectionManager()
{
    if (m_currentReply) {
        m_currentReply->abort();
        m_currentReply->deleteLater();
    }
}

void LLMConnectionManager::setCurrentProvider(Provider provider)
{
    if (m_currentProvider != provider) {
        m_currentProvider = provider;
        emit currentProviderChanged();
        
        // Reset connection status when provider changes
        setConnectionStatus(false);
        
        // Update default base URL based on provider
        switch (provider) {
        case OpenAI:
            if (m_baseUrl.isEmpty() || m_baseUrl.contains("localhost")) {
                setBaseUrl("https://api.openai.com/v1");
            }
            if (m_model.isEmpty()) {
                setModel("gpt-3.5-turbo");
            }
            break;
        case LMStudio:
            if (m_baseUrl.isEmpty() || !m_baseUrl.contains("localhost")) {
                setBaseUrl("http://localhost:1234/v1");
            }
            if (m_model.isEmpty()) {
                setModel("local-model");
            }
            break;
        case Ollama:
            if (m_baseUrl.isEmpty() || !m_baseUrl.contains("localhost")) {
                setBaseUrl("http://localhost:11434");
            }
            if (m_model.isEmpty()) {
                setModel("llama2");
            }
            break;
        }
        
        qDebug() << "Provider changed to:" << provider << "Base URL:" << m_baseUrl;
    }
}

void LLMConnectionManager::setApiKey(const QString &key)
{
    if (m_apiKey != key) {
        m_apiKey = key;
        emit apiKeyChanged();
        
        // Reset connection status when API key changes
        setConnectionStatus(false);
        
        qDebug() << "API key updated";
    }
}

void LLMConnectionManager::setBaseUrl(const QString &url)
{
    if (m_baseUrl != url) {
        m_baseUrl = url;
        emit baseUrlChanged();
        
        // Reset connection status when URL changes
        setConnectionStatus(false);
        
        qDebug() << "Base URL updated to:" << url;
    }
}

void LLMConnectionManager::setModel(const QString &model)
{
    if (m_model != model) {
        m_model = model;
        emit modelChanged();
        
        qDebug() << "Model updated to:" << model;
    }
}

void LLMConnectionManager::setConnectionStatus(bool connected)
{
    if (m_isConnected != connected) {
        m_isConnected = connected;
        emit isConnectedChanged();
        
        qDebug() << "Connection status:" << (connected ? "Connected" : "Disconnected");
    }
}

void LLMConnectionManager::testConnection()
{
    // Don't start a new test if one is already in progress
    if (m_isTestingConnection) {
        qDebug() << "Connection test already in progress, skipping";
        return;
    }
    
    qDebug() << "Testing connection to provider:" << m_currentProvider;
    
    // Cancel any existing request
    cancelRequest();
    
    m_isTestingConnection = true;
    emit requestStarted();
    
    switch (m_currentProvider) {
    case OpenAI:
        testOpenAIConnection();
        break;
    case LMStudio:
        testLMStudioConnection();
        break;
    case Ollama:
        testOllamaConnection();
        break;
    }
}

void LLMConnectionManager::testOpenAIConnection()
{
    if (m_apiKey.isEmpty()) {
        emit error("OpenAI API key is required");
        emit requestFinished();
        return;
    }
    
    QNetworkRequest request;
    request.setUrl(QUrl(m_baseUrl + "/models"));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    request.setRawHeader("Authorization", QString("Bearer %1").arg(m_apiKey).toUtf8());
    
    m_currentReply = m_networkManager->get(request);
    connectReplySignals(true); // This is a test connection
    
    qDebug() << "Testing OpenAI connection to:" << request.url();
}

void LLMConnectionManager::testLMStudioConnection()
{
    QNetworkRequest request;
    request.setUrl(QUrl(m_baseUrl + "/models"));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    
    // Add headers to prevent connection issues
    request.setRawHeader("User-Agent", "VoiceAILLM/1.0");
    request.setRawHeader("Connection", "close");
    request.setRawHeader("Cache-Control", "no-cache");
    
    qDebug() << "Testing LM Studio connection to:" << request.url();
    qDebug() << "Base URL configured as:" << m_baseUrl;
    
    m_currentReply = m_networkManager->get(request);
    connectReplySignals(true); // This is a test connection
}

void LLMConnectionManager::testOllamaConnection()
{
    QNetworkRequest request;
    request.setUrl(QUrl(m_baseUrl + "/api/tags"));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    
    m_currentReply = m_networkManager->get(request);
    connectReplySignals(true); // This is a test connection
    
    qDebug() << "Testing Ollama connection to:" << request.url();
}

void LLMConnectionManager::connectReplySignals(bool isTestConnection)
{
    if (!m_currentReply) return;
    
    if (isTestConnection) {
        connect(m_currentReply, &QNetworkReply::finished, this, &LLMConnectionManager::handleTestConnectionReply);
    } else {
        connect(m_currentReply, &QNetworkReply::finished, this, &LLMConnectionManager::handleNetworkReply);
    }
    
    connect(m_currentReply, &QNetworkReply::errorOccurred, this, [this](QNetworkReply::NetworkError error) {
        QString errorString = m_currentReply ? m_currentReply->errorString() : "Unknown network error";
        qDebug() << "Network error occurred:" << error << errorString;
        
        // Reset testing flag on error
        m_isTestingConnection = false;
        
        setConnectionStatus(false);
        emit this->error(QString("Network error: %1").arg(errorString));
        emit requestFinished();
    });
    
    // Set intelligent timeout based on operation type and model size
    int timeoutMs = getTimeoutForOperation(isTestConnection);
    qDebug() << QString("Setting timeout to %1 seconds for %2").arg(timeoutMs/1000).arg(isTestConnection ? "connection test" : "message request");
    
    QTimer::singleShot(timeoutMs, this, [this, timeoutMs, isTestConnection]() {
        if (m_currentReply && !m_currentReply->isFinished()) {
            qDebug() << QString("Request timeout after %1 seconds").arg(timeoutMs/1000);
            m_currentReply->abort();
            
            if (isTestConnection) {
                m_isTestingConnection = false;
                setConnectionStatus(false);
                emit error("Connection test timeout - check if server is running");
            } else {
                setConnectionStatus(false);
                QString errorMsg = QString("Response timeout after %1 seconds").arg(timeoutMs/1000);
                
                // Add helpful context based on model type
                if (m_model.contains("qwen", Qt::CaseInsensitive) || 
                    m_model.contains("llama", Qt::CaseInsensitive) ||
                    m_model.contains("32b", Qt::CaseInsensitive) ||
                    m_model.contains("70b", Qt::CaseInsensitive)) {
                    errorMsg += " - Large models may need more time. Consider using a smaller model or increasing timeout.";
                } else {
                    errorMsg += " - Check if LM Studio is running and model is loaded.";
                }
                
                emit error(errorMsg);
            }
            emit requestFinished();
        }
    });
}

void LLMConnectionManager::handleTestConnectionReply()
{
    // Always reset the testing flag when the test completes
    m_isTestingConnection = false;
    
    if (!m_currentReply) {
        emit requestFinished();
        return;
    }
    
    // Check if the reply was aborted/canceled
    if (m_currentReply->error() == QNetworkReply::OperationCanceledError) {
        qDebug() << "Connection test was canceled";
        m_currentReply->deleteLater();
        m_currentReply = nullptr;
        emit requestFinished();
        return;
    }
    
    QByteArray response;
    int statusCode = 0;
    
    // Only try to read if the device is still open
    if (m_currentReply->isOpen()) {
        response = m_currentReply->readAll();
        statusCode = m_currentReply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt();
    }
    
    qDebug() << "Test connection response - Status:" << statusCode << "Response size:" << response.size();
    
    m_currentReply->deleteLater();
    m_currentReply = nullptr;
    
    if (statusCode == 200) {
        setConnectionStatus(true);
        qDebug() << "Connection test successful";
    } else {
        setConnectionStatus(false);
        QString errorMsg = QString("Connection test failed - HTTP %1").arg(statusCode);
        if (!response.isEmpty()) {
            QJsonDocument doc = QJsonDocument::fromJson(response);
            if (!doc.isNull()) {
                QJsonObject obj = doc.object();
                if (obj.contains("error")) {
                    QJsonObject errorObj = obj["error"].toObject();
                    errorMsg += ": " + errorObj["message"].toString();
                }
            } else {
                errorMsg += ": " + QString::fromUtf8(response);
            }
        }
        qDebug() << errorMsg;
        emit error(errorMsg);
    }
    
    emit requestFinished();
}

void LLMConnectionManager::sendMessage(const QString &message, const QString &systemPrompt)
{
    if (message.isEmpty()) {
        return;
    }
    
    qDebug() << "Sending message to" << m_currentProvider << ":" << message.left(50) + "...";
    
    // Cancel any existing request
    cancelRequest();
    
    emit requestStarted();
    
    switch (m_currentProvider) {
    case OpenAI:
        sendOpenAIRequest(message, systemPrompt);
        break;
    case LMStudio:
        sendLMStudioRequest(message, systemPrompt);
        break;
    case Ollama:
        sendOllamaRequest(message, systemPrompt);
        break;
    }
}

void LLMConnectionManager::sendOpenAIRequest(const QString &message, const QString &systemPrompt)
{
    if (m_apiKey.isEmpty()) {
        emit error("OpenAI API key is required");
        emit requestFinished();
        return;
    }
    
    QNetworkRequest request;
    request.setUrl(QUrl(m_baseUrl + "/chat/completions"));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    request.setRawHeader("Authorization", QString("Bearer %1").arg(m_apiKey).toUtf8());
    
    QJsonObject requestBody = createRequestBody(message, systemPrompt);
    requestBody["model"] = m_model;
    requestBody["stream"] = false;
    requestBody["max_tokens"] = 1000;
    requestBody["temperature"] = 0.7;
    
    QJsonDocument doc(requestBody);
    m_currentReply = m_networkManager->post(request, doc.toJson());
    connectReplySignals(false); // This is not a test connection
}

void LLMConnectionManager::sendLMStudioRequest(const QString &message, const QString &systemPrompt)
{
    QNetworkRequest request;
    request.setUrl(QUrl(m_baseUrl + "/chat/completions"));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    
    // Add headers to prevent connection issues
    request.setRawHeader("User-Agent", "VoiceAILLM/1.0");
    request.setRawHeader("Connection", "close");
    request.setRawHeader("Cache-Control", "no-cache");
    
    QJsonObject requestBody = createRequestBody(message, systemPrompt);
    requestBody["model"] = m_model;
    requestBody["stream"] = false;
    requestBody["max_tokens"] = 1000;
    requestBody["temperature"] = 0.7;
    
    qDebug() << "Sending LM Studio request to:" << request.url();
    qDebug() << "Message length:" << message.length() << "characters";
    qDebug() << "Model:" << m_model;
    
    QJsonDocument doc(requestBody);
    m_currentReply = m_networkManager->post(request, doc.toJson());
    connectReplySignals(false); // This is not a test connection
}

void LLMConnectionManager::sendOllamaRequest(const QString &message, const QString &systemPrompt)
{
    QNetworkRequest request;
    request.setUrl(QUrl(m_baseUrl + "/api/chat"));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    
    QJsonObject requestBody;
    requestBody["model"] = m_model;
    requestBody["stream"] = false;
    
    QJsonArray messages;
    if (!systemPrompt.isEmpty()) {
        QJsonObject systemMsg;
        systemMsg["role"] = "system";
        systemMsg["content"] = systemPrompt;
        messages.append(systemMsg);
    }
    
    QJsonObject userMsg;
    userMsg["role"] = "user";
    userMsg["content"] = message;
    messages.append(userMsg);
    
    requestBody["messages"] = messages;
    
    QJsonDocument doc(requestBody);
    m_currentReply = m_networkManager->post(request, doc.toJson());
    connectReplySignals(false); // This is not a test connection
}

QJsonObject LLMConnectionManager::createRequestBody(const QString &message, const QString &systemPrompt)
{
    QJsonObject requestBody;
    QJsonArray messages;
    
    if (!systemPrompt.isEmpty()) {
        QJsonObject systemMsg;
        systemMsg["role"] = "system";
        systemMsg["content"] = systemPrompt;
        messages.append(systemMsg);
    }
    
    QJsonObject userMsg;
    userMsg["role"] = "user";
    userMsg["content"] = message;
    messages.append(userMsg);
    
    requestBody["messages"] = messages;
    return requestBody;
}

void LLMConnectionManager::handleNetworkReply()
{
    if (!m_currentReply) {
        return;
    }
    
    QByteArray response = m_currentReply->readAll();
    int statusCode = m_currentReply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt();
    
    qDebug() << "Message response - Status:" << statusCode << "Response size:" << response.size();
    
    m_currentReply->deleteLater();
    m_currentReply = nullptr;
    
    if (statusCode != 200) {
        QString errorMsg = QString("HTTP error %1").arg(statusCode);
        if (!response.isEmpty()) {
            QJsonDocument doc = QJsonDocument::fromJson(response);
            if (!doc.isNull()) {
                QJsonObject obj = doc.object();
                if (obj.contains("error")) {
                    QJsonObject errorObj = obj["error"].toObject();
                    errorMsg += ": " + errorObj["message"].toString();
                }
            } else {
                errorMsg += ": " + QString::fromUtf8(response);
            }
        }
        qDebug() << errorMsg;
        emit error(errorMsg);
        emit requestFinished();
        return;
    }
    
    QJsonDocument doc = QJsonDocument::fromJson(response);
    if (doc.isNull()) {
        emit error("Invalid JSON response");
        emit requestFinished();
        return;
    }
    
    QJsonObject obj = doc.object();
    QString responseText;
    
    if (m_currentProvider == Ollama) {
        // Ollama response format
        QJsonObject message = obj["message"].toObject();
        responseText = message["content"].toString();
    } else {
        // OpenAI/LM Studio response format
        QJsonArray choices = obj["choices"].toArray();
        if (!choices.isEmpty()) {
            QJsonObject choice = choices.first().toObject();
            QJsonObject message = choice["message"].toObject();
            responseText = message["content"].toString();
        }
    }
    
    if (!responseText.isEmpty()) {
        qDebug() << "Response received:" << responseText.left(100) + "...";
        emit responseReceived(responseText);
    } else {
        emit error("Empty response received");
    }
    
    emit requestFinished();
}

void LLMConnectionManager::cancelRequest()
{
    if (m_currentReply) {
        qDebug() << "Canceling current request";
        m_currentReply->abort();
        m_currentReply->deleteLater();
        m_currentReply = nullptr;
        emit requestFinished();
    }
}

int LLMConnectionManager::getTimeoutForOperation(bool isTestConnection) const
{
    if (isTestConnection) {
        // Connection tests should be quick
        return 30000; // 30 seconds
    }
    
    // For message requests, use intelligent timeout based on model characteristics
    QString modelLower = m_model.toLower();
    
    // Large models (32B, 70B parameters) need much more time
    if (modelLower.contains("70b") || modelLower.contains("72b")) {
        qDebug() << "Detected 70B+ parameter model, using extended timeout";
        return 300000; // 5 minutes for 70B models
    }
    else if (modelLower.contains("32b") || modelLower.contains("34b")) {
        qDebug() << "Detected 32B parameter model, using extended timeout";
        return 240000; // 4 minutes for 32B models  
    }
    else if (modelLower.contains("13b") || modelLower.contains("14b") || modelLower.contains("15b")) {
        qDebug() << "Detected 13-15B parameter model, using moderate timeout";
        return 180000; // 3 minutes for 13-15B models
    }
    else if (modelLower.contains("7b") || modelLower.contains("8b") || modelLower.contains("9b")) {
        qDebug() << "Detected 7-9B parameter model, using standard timeout";
        return 120000; // 2 minutes for 7-9B models
    }
    else if (modelLower.contains("3b") || modelLower.contains("4b")) {
        qDebug() << "Detected 3-4B parameter model, using reduced timeout";
        return 90000;  // 1.5 minutes for 3-4B models
    }
    else if (modelLower.contains("1b") || modelLower.contains("2b")) {
        qDebug() << "Detected 1-2B parameter model, using minimal timeout";
        return 60000;  // 1 minute for small models
    }
    
    // Check for specific model families that are known to be slow
    if (modelLower.contains("qwen") || modelLower.contains("deepseek") || 
        modelLower.contains("mixtral") || modelLower.contains("wizardlm")) {
        qDebug() << "Detected potentially slow model family, using extended timeout";
        return 180000; // 3 minutes for known slow families
    }
    
    // Check provider-specific defaults
    switch (m_currentProvider) {
        case LMStudio:
            // LM Studio can be slow with local inference
            return 150000; // 2.5 minutes default for LM Studio
        case Ollama:
            // Ollama is usually reasonably fast
            return 120000; // 2 minutes default for Ollama
        case OpenAI:
            // OpenAI API is usually fast
            return 60000;  // 1 minute for OpenAI API
        default:
            return 120000; // 2 minutes default
    }
} 