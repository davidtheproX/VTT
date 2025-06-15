#include "OAuth2Manager.h"
#include "QRCodeGenerator.h"
#include "LoggingManager.h"
#include "SecureStorageManager.h"

#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QNetworkRequest>
#include <QUrlQuery>
#include <QRandomGenerator>
#include <QDesktopServices>
#include <QCoreApplication>

// API endpoints for WeChat
const QString OAuth2Manager::WECHAT_QR_URL = "https://api.weixin.qq.com/cgi-bin/qrcode/create";
const QString OAuth2Manager::WECHAT_CHECK_QR_URL = "https://api.weixin.qq.com/cgi-bin/user/info";
const QString OAuth2Manager::WECHAT_ACCESS_TOKEN_URL = "https://api.weixin.qq.com/sns/oauth2/access_token";
const QString OAuth2Manager::WECHAT_USER_INFO_URL = "https://api.weixin.qq.com/sns/userinfo";
const QString OAuth2Manager::WECHAT_OAUTH_URL = "https://open.weixin.qq.com/connect/oauth2/authorize";

// API endpoints for DingTalk
const QString OAuth2Manager::DINGTALK_QR_URL = "https://oapi.dingtalk.com/connect/qrconnect";
const QString OAuth2Manager::DINGTALK_CHECK_QR_URL = "https://oapi.dingtalk.com/sns/getuserinfo_bycode";
const QString OAuth2Manager::DINGTALK_ACCESS_TOKEN_URL = "https://oapi.dingtalk.com/sns/gettoken";
const QString OAuth2Manager::DINGTALK_USER_INFO_URL = "https://oapi.dingtalk.com/topapi/v2/user/get";
const QString OAuth2Manager::DINGTALK_OAUTH_URL = "https://login.dingtalk.com/oauth2/auth";

OAuth2Manager::OAuth2Manager(QObject *parent)
    : QObject(parent)
    , m_networkManager(nullptr)
    , m_qrGenerator(nullptr)
    , m_weChatQRTimer(nullptr)
    , m_dingTalkQRTimer(nullptr)
    , m_weChatAuthenticated(false)
    , m_dingTalkAuthenticated(false)
    , m_weChatLoading(false)
    , m_dingTalkLoading(false)
{
    initializeNetworkManager();
    
    // Initialize QR code generator
    m_qrGenerator = new QRCodeGenerator(this);
    
    // Initialize timers
    m_weChatQRTimer = new QTimer(this);
    m_weChatQRTimer->setSingleShot(false);
    m_weChatQRTimer->setInterval(QR_CODE_CHECK_INTERVAL);
    connect(m_weChatQRTimer, &QTimer::timeout, this, [this]() {
        checkQRCodeStatus(Provider::WeChat);
    });
    
    m_dingTalkQRTimer = new QTimer(this);
    m_dingTalkQRTimer->setSingleShot(false);
    m_dingTalkQRTimer->setInterval(QR_CODE_CHECK_INTERVAL);
    connect(m_dingTalkQRTimer, &QTimer::timeout, this, [this]() {
        checkQRCodeStatus(Provider::DingTalk);
    });
    
    // Load existing credentials
    loadCredentials(Provider::WeChat);
    loadCredentials(Provider::DingTalk);
    
    LoggingManager::instance()->debugGeneral("OAuth2Manager initialized");
}

OAuth2Manager::~OAuth2Manager()
{
    if (m_weChatQRTimer && m_weChatQRTimer->isActive()) {
        m_weChatQRTimer->stop();
    }
    if (m_dingTalkQRTimer && m_dingTalkQRTimer->isActive()) {
        m_dingTalkQRTimer->stop();
    }
}

void OAuth2Manager::initializeNetworkManager()
{
    m_networkManager = new QNetworkAccessManager(this);
    
    // Note: QNetworkAccessManager doesn't have setUserAgent in Qt6
    // User agent is set per request if needed
}

void OAuth2Manager::setWeChatCredentials(const QString &appId, const QString &appSecret)
{
    m_weChatAppId = appId;
    m_weChatAppSecret = appSecret;
    saveCredentials(Provider::WeChat);
    
    LoggingManager::instance()->debugGeneral("WeChat credentials updated");
}

void OAuth2Manager::setDingTalkCredentials(const QString &appId, const QString &appSecret)
{
    m_dingTalkAppId = appId;
    m_dingTalkAppSecret = appSecret;
    saveCredentials(Provider::DingTalk);
    
    LoggingManager::instance()->debugGeneral("DingTalk credentials updated");
}

void OAuth2Manager::authenticateWeChat(AuthMethod method)
{
    if (m_weChatAppId.isEmpty()) {
        emit authenticationError(Provider::WeChat, "WeChat App ID not configured");
        return;
    }
    
    setWeChatLoading(true);
    
    if (method == AuthMethod::QRCode) {
        refreshWeChatQRCode();
    } else {
        startWeChatOAuth();
    }
}

void OAuth2Manager::authenticateDingTalk(AuthMethod method)
{
    if (m_dingTalkAppId.isEmpty()) {
        emit authenticationError(Provider::DingTalk, "DingTalk App ID not configured");
        return;
    }
    
    setDingTalkLoading(true);
    
    if (method == AuthMethod::QRCode) {
        refreshDingTalkQRCode();
    } else {
        startDingTalkOAuth();
    }
}

void OAuth2Manager::refreshWeChatQRCode()
{
    if (m_weChatAppId.isEmpty()) {
        emit authenticationError(Provider::WeChat, "WeChat credentials not set");
        return;
    }
    
    // Create QR code URL for WeChat web login
    QString qrUrl = QString("https://open.weixin.qq.com/connect/qrconnect?appid=%1&redirect_uri=%2&response_type=code&scope=snsapi_login&state=%3#wechat_redirect")
                    .arg(m_weChatAppId)
                    .arg(QUrl::toPercentEncoding("http://localhost:8080/wechat/callback"))
                    .arg(generateRandomState());
    
    // Generate QR code
    m_weChatQRCode = m_qrGenerator->generateQRCodeDataURI(qrUrl, 256);
    emit weChatQRCodeChanged();
    
    // Setup OAuth handler for callback
    setupWeChatOAuth();
    
    LoggingManager::instance()->debugGeneral("WeChat QR code generated");
}

void OAuth2Manager::refreshDingTalkQRCode()
{
    if (m_dingTalkAppId.isEmpty()) {
        emit authenticationError(Provider::DingTalk, "DingTalk credentials not set");
        return;
    }
    
    // Create QR code URL for DingTalk web login
    QString qrUrl = QString("https://login.dingtalk.com/oauth2/auth?redirect_uri=%1&response_type=code&client_id=%2&scope=openid&state=%3&prompt=consent")
                    .arg(QUrl::toPercentEncoding("http://localhost:8080/dingtalk/callback"))
                    .arg(m_dingTalkAppId)
                    .arg(generateRandomState());
    
    // Generate QR code
    m_dingTalkQRCode = m_qrGenerator->generateQRCodeDataURI(qrUrl, 256);
    emit dingTalkQRCodeChanged();
    
    // Setup OAuth handler for callback
    setupDingTalkOAuth();
    
    LoggingManager::instance()->debugGeneral("DingTalk QR code generated");
}

void OAuth2Manager::setupWeChatOAuth()
{
    if (!m_weChatOAuth) {
        m_weChatOAuth = std::make_unique<QOAuth2AuthorizationCodeFlow>(this);
        m_weChatReplyHandler = std::make_unique<QOAuthHttpServerReplyHandler>(8080, this);
        
        m_weChatOAuth->setReplyHandler(m_weChatReplyHandler.get());
        m_weChatOAuth->setAuthorizationUrl(QUrl(WECHAT_OAUTH_URL));
        m_weChatOAuth->setTokenUrl(QUrl(WECHAT_ACCESS_TOKEN_URL));
        m_weChatOAuth->setClientIdentifier(m_weChatAppId);
        m_weChatOAuth->setClientIdentifierSharedKey(m_weChatAppSecret);
        m_weChatOAuth->setRequestedScopeTokens({QByteArray("snsapi_login")});
        
        connect(m_weChatOAuth.get(), &QOAuth2AuthorizationCodeFlow::statusChanged, this, [this](QAbstractOAuth::Status status) {
            if (status == QAbstractOAuth::Status::Granted) {
                m_weChatAccessToken = m_weChatOAuth->token();
                m_weChatAuthenticated = true;
                setWeChatLoading(false);
                refreshUserInfo(Provider::WeChat);
                emit weChatAuthenticationChanged();
                emit authenticationSuccess(Provider::WeChat);
                LoggingManager::instance()->debugGeneral("WeChat authentication successful");
            } else if (status == QAbstractOAuth::Status::NotAuthenticated) {
                setWeChatLoading(false);
                emit authenticationError(Provider::WeChat, "Authentication failed");
            }
        });
        
        connect(m_weChatOAuth.get(), &QOAuth2AuthorizationCodeFlow::serverReportedErrorOccurred, this, [this](const QString &error, const QString &errorDescription) {
            setWeChatLoading(false);
            emit authenticationError(Provider::WeChat, QString("%1: %2").arg(error, errorDescription));
        });
    }
}

void OAuth2Manager::setupDingTalkOAuth()
{
    if (!m_dingTalkOAuth) {
        m_dingTalkOAuth = std::make_unique<QOAuth2AuthorizationCodeFlow>(this);
        m_dingTalkReplyHandler = std::make_unique<QOAuthHttpServerReplyHandler>(8081, this);
        
        m_dingTalkOAuth->setReplyHandler(m_dingTalkReplyHandler.get());
        m_dingTalkOAuth->setAuthorizationUrl(QUrl(DINGTALK_OAUTH_URL));
        m_dingTalkOAuth->setTokenUrl(QUrl(DINGTALK_ACCESS_TOKEN_URL));
        m_dingTalkOAuth->setClientIdentifier(m_dingTalkAppId);
        m_dingTalkOAuth->setClientIdentifierSharedKey(m_dingTalkAppSecret);
        m_dingTalkOAuth->setRequestedScopeTokens({QByteArray("openid")});
        
        connect(m_dingTalkOAuth.get(), &QOAuth2AuthorizationCodeFlow::statusChanged, this, [this](QAbstractOAuth::Status status) {
            if (status == QAbstractOAuth::Status::Granted) {
                m_dingTalkAccessToken = m_dingTalkOAuth->token();
                m_dingTalkAuthenticated = true;
                setDingTalkLoading(false);
                refreshUserInfo(Provider::DingTalk);
                emit dingTalkAuthenticationChanged();
                emit authenticationSuccess(Provider::DingTalk);
                LoggingManager::instance()->debugGeneral("DingTalk authentication successful");
            } else if (status == QAbstractOAuth::Status::NotAuthenticated) {
                setDingTalkLoading(false);
                emit authenticationError(Provider::DingTalk, "Authentication failed");
            }
        });
        
        connect(m_dingTalkOAuth.get(), &QOAuth2AuthorizationCodeFlow::serverReportedErrorOccurred, this, [this](const QString &error, const QString &errorDescription) {
            setDingTalkLoading(false);
            emit authenticationError(Provider::DingTalk, QString("%1: %2").arg(error, errorDescription));
        });
    }
}

void OAuth2Manager::startWeChatOAuth()
{
    setupWeChatOAuth();
    if (m_weChatOAuth) {
        m_weChatOAuth->grant();
    }
}

void OAuth2Manager::startDingTalkOAuth()
{
    setupDingTalkOAuth();
    if (m_dingTalkOAuth) {
        m_dingTalkOAuth->grant();
    }
}

void OAuth2Manager::checkQRCodeStatus(Provider provider)
{
    // Check QR code scan status via API polling
    if (provider == Provider::WeChat && !m_weChatQRCode.isEmpty()) {
        // WeChat QR code status check
        QUrl url("https://api.weixin.qq.com/cgi-bin/qrcode/check_status");
        QUrlQuery query;
        query.addQueryItem("qr_code", m_weChatQRCode);
        query.addQueryItem("app_id", m_weChatAppId);
        url.setQuery(query);
        
        QNetworkRequest request(url);
        request.setRawHeader("User-Agent", "VoiceAI-LLM/1.0");
        
        QNetworkReply *reply = m_networkManager->get(request);
        connect(reply, &QNetworkReply::finished, this, [this, reply]() {
            reply->deleteLater();
            
            if (reply->error() == QNetworkReply::NoError) {
                QJsonDocument doc = QJsonDocument::fromJson(reply->readAll());
                QJsonObject response = doc.object();
                
                if (response["status"].toString() == "scanned") {
                    // QR code was scanned, exchange for access token
                    QString authCode = response["code"].toString();
                    if (!authCode.isEmpty()) {
                        exchangeWeChatAuthCode(authCode);
                    }
                } else if (response["status"].toString() == "expired") {
                    // QR code expired, generate new one
                    refreshWeChatQRCode();
                }
            }
        });
    } else if (provider == Provider::DingTalk && !m_dingTalkQRCode.isEmpty()) {
        // DingTalk QR code status check
        QUrl url("https://oapi.dingtalk.com/connect/qrconnect/check");
        QUrlQuery query;
        query.addQueryItem("qr_code", m_dingTalkQRCode);
        query.addQueryItem("app_id", m_dingTalkAppId);
        url.setQuery(query);
        
        QNetworkRequest request(url);
        request.setRawHeader("User-Agent", "VoiceAI-LLM/1.0");
        
        QNetworkReply *reply = m_networkManager->get(request);
        connect(reply, &QNetworkReply::finished, this, [this, reply]() {
            reply->deleteLater();
            
            if (reply->error() == QNetworkReply::NoError) {
                QJsonDocument doc = QJsonDocument::fromJson(reply->readAll());
                QJsonObject response = doc.object();
                
                if (response["errcode"].toInt() == 0) {
                    QString status = response["status"].toString();
                    if (status == "scanned") {
                        // QR code was scanned, exchange for access token
                        QString authCode = response["auth_code"].toString();
                        if (!authCode.isEmpty()) {
                            exchangeDingTalkAuthCode(authCode);
                        }
                    } else if (status == "expired") {
                        // QR code expired, generate new one
                        refreshDingTalkQRCode();
                    }
                }
            }
        });
    }
}

void OAuth2Manager::refreshUserInfo(Provider provider)
{
    if (provider == Provider::WeChat && !m_weChatAccessToken.isEmpty()) {
        QUrl url(WECHAT_USER_INFO_URL);
        QUrlQuery query;
        query.addQueryItem("access_token", m_weChatAccessToken);
        query.addQueryItem("openid", m_weChatOpenId);
        query.addQueryItem("lang", "zh_CN");
        url.setQuery(query);
        
        QNetworkRequest request(url);
        QNetworkReply *reply = m_networkManager->get(request);
        connect(reply, &QNetworkReply::finished, this, [this, reply]() {
            onWeChatUserInfoReceived(reply);
        });
    } else if (provider == Provider::DingTalk && !m_dingTalkAccessToken.isEmpty()) {
        QUrl url(DINGTALK_USER_INFO_URL);
        QUrlQuery query;
        query.addQueryItem("access_token", m_dingTalkAccessToken);
        query.addQueryItem("userid", m_dingTalkUserId);
        url.setQuery(query);
        
        QNetworkRequest request(url);
        QNetworkReply *reply = m_networkManager->get(request);
        connect(reply, &QNetworkReply::finished, this, [this, reply]() {
            onDingTalkUserInfoReceived(reply);
        });
    }
}

void OAuth2Manager::onWeChatUserInfoReceived(QNetworkReply *reply)
{
    reply->deleteLater();
    
    if (reply->error() != QNetworkReply::NoError) {
        emit authenticationError(Provider::WeChat, QString("Failed to get user info: %1").arg(reply->errorString()));
        return;
    }
    
    QJsonDocument doc = QJsonDocument::fromJson(reply->readAll());
    if (doc.isObject()) {
        QJsonObject userInfo = doc.object();
        if (userInfo.contains("errcode")) {
            emit authenticationError(Provider::WeChat, userInfo["errmsg"].toString());
        } else {
            m_weChatUserInfo = doc.toJson(QJsonDocument::Compact);
            emit weChatUserInfoChanged();
            LoggingManager::instance()->debugGeneral("WeChat user info updated");
        }
    }
}

void OAuth2Manager::onDingTalkUserInfoReceived(QNetworkReply *reply)
{
    reply->deleteLater();
    
    if (reply->error() != QNetworkReply::NoError) {
        emit authenticationError(Provider::DingTalk, QString("Failed to get user info: %1").arg(reply->errorString()));
        return;
    }
    
    QJsonDocument doc = QJsonDocument::fromJson(reply->readAll());
    if (doc.isObject()) {
        QJsonObject response = doc.object();
        if (response["errcode"].toInt() == 0) {
            m_dingTalkUserInfo = doc.toJson(QJsonDocument::Compact);
            emit dingTalkUserInfoChanged();
            LoggingManager::instance()->debugGeneral("DingTalk user info updated");
        } else {
            emit authenticationError(Provider::DingTalk, response["errmsg"].toString());
        }
    }
}

void OAuth2Manager::logoutWeChat()
{
    m_weChatAuthenticated = false;
    m_weChatAccessToken.clear();
    m_weChatRefreshToken.clear();
    m_weChatUserInfo.clear();
    m_weChatQRCode.clear();
    m_weChatOpenId.clear();
    
    if (m_weChatQRTimer->isActive()) {
        m_weChatQRTimer->stop();
    }
    
    clearCredentials(Provider::WeChat);
    
    emit weChatAuthenticationChanged();
    emit weChatUserInfoChanged();
    emit weChatQRCodeChanged();
    
    LoggingManager::instance()->debugGeneral("WeChat logout completed");
}

void OAuth2Manager::logoutDingTalk()
{
    m_dingTalkAuthenticated = false;
    m_dingTalkAccessToken.clear();
    m_dingTalkRefreshToken.clear();
    m_dingTalkUserInfo.clear();
    m_dingTalkQRCode.clear();
    m_dingTalkUserId.clear();
    
    if (m_dingTalkQRTimer->isActive()) {
        m_dingTalkQRTimer->stop();
    }
    
    clearCredentials(Provider::DingTalk);
    
    emit dingTalkAuthenticationChanged();
    emit dingTalkUserInfoChanged();
    emit dingTalkQRCodeChanged();
    
    LoggingManager::instance()->debugGeneral("DingTalk logout completed");
}

void OAuth2Manager::logoutAll()
{
    logoutWeChat();
    logoutDingTalk();
}

void OAuth2Manager::setWeChatLoading(bool loading)
{
    if (m_weChatLoading != loading) {
        m_weChatLoading = loading;
        emit weChatLoadingChanged();
    }
}

void OAuth2Manager::setDingTalkLoading(bool loading)
{
    if (m_dingTalkLoading != loading) {
        m_dingTalkLoading = loading;
        emit dingTalkLoadingChanged();
    }
}

QString OAuth2Manager::generateRandomState() const
{
    QByteArray data;
    data.resize(16);
    for (int i = 0; i < 16; ++i) {
        data[i] = QRandomGenerator::global()->bounded(256);
    }
    return data.toHex();
}

void OAuth2Manager::saveCredentials(Provider provider)
{
    SecureStorageManager storage;
    
    if (provider == Provider::WeChat) {
        storage.storeCredential("wechat_app_id", m_weChatAppId);
        storage.storeCredential("wechat_app_secret", m_weChatAppSecret);
        if (!m_weChatAccessToken.isEmpty()) {
            storage.storeCredential("wechat_access_token", m_weChatAccessToken);
        }
        if (!m_weChatRefreshToken.isEmpty()) {
            storage.storeCredential("wechat_refresh_token", m_weChatRefreshToken);
        }
    } else if (provider == Provider::DingTalk) {
        storage.storeCredential("dingtalk_app_id", m_dingTalkAppId);
        storage.storeCredential("dingtalk_app_secret", m_dingTalkAppSecret);
        if (!m_dingTalkAccessToken.isEmpty()) {
            storage.storeCredential("dingtalk_access_token", m_dingTalkAccessToken);
        }
        if (!m_dingTalkRefreshToken.isEmpty()) {
            storage.storeCredential("dingtalk_refresh_token", m_dingTalkRefreshToken);
        }
    }
}

void OAuth2Manager::loadCredentials(Provider provider)
{
    SecureStorageManager storage;
    
    if (provider == Provider::WeChat) {
        m_weChatAppId = storage.retrieveCredential("wechat_app_id");
        m_weChatAppSecret = storage.retrieveCredential("wechat_app_secret");
        m_weChatAccessToken = storage.retrieveCredential("wechat_access_token");
        m_weChatRefreshToken = storage.retrieveCredential("wechat_refresh_token");
        
        if (!m_weChatAccessToken.isEmpty()) {
            m_weChatAuthenticated = true;
            emit weChatAuthenticationChanged();
        }
    } else if (provider == Provider::DingTalk) {
        m_dingTalkAppId = storage.retrieveCredential("dingtalk_app_id");
        m_dingTalkAppSecret = storage.retrieveCredential("dingtalk_app_secret");
        m_dingTalkAccessToken = storage.retrieveCredential("dingtalk_access_token");
        m_dingTalkRefreshToken = storage.retrieveCredential("dingtalk_refresh_token");
        
        if (!m_dingTalkAccessToken.isEmpty()) {
            m_dingTalkAuthenticated = true;
            emit dingTalkAuthenticationChanged();
        }
    }
}

void OAuth2Manager::clearCredentials(Provider provider)
{
    SecureStorageManager storage;
    
    if (provider == Provider::WeChat) {
        storage.deleteCredential("wechat_access_token");
        storage.deleteCredential("wechat_refresh_token");
    } else if (provider == Provider::DingTalk) {
        storage.deleteCredential("dingtalk_access_token");
        storage.deleteCredential("dingtalk_refresh_token");
    }
}

void OAuth2Manager::exchangeWeChatAuthCode(const QString &authCode)
{
    if (authCode.isEmpty() || m_weChatAppId.isEmpty() || m_weChatAppSecret.isEmpty()) {
        emit authenticationError(Provider::WeChat, "Missing auth code or credentials");
        return;
    }
    
    QUrl url(WECHAT_ACCESS_TOKEN_URL);
    QUrlQuery query;
    query.addQueryItem("appid", m_weChatAppId);
    query.addQueryItem("secret", m_weChatAppSecret);
    query.addQueryItem("code", authCode);
    query.addQueryItem("grant_type", "authorization_code");
    url.setQuery(query);
    
    QNetworkRequest request(url);
    request.setRawHeader("User-Agent", "VoiceAI-LLM/1.0");
    
    QNetworkReply *reply = m_networkManager->get(request);
    connect(reply, &QNetworkReply::finished, this, [this, reply]() {
        reply->deleteLater();
        
        if (reply->error() == QNetworkReply::NoError) {
            QJsonDocument doc = QJsonDocument::fromJson(reply->readAll());
            QJsonObject response = doc.object();
            
            if (response.contains("access_token")) {
                m_weChatAccessToken = response["access_token"].toString();
                m_weChatRefreshToken = response["refresh_token"].toString();
                m_weChatOpenId = response["openid"].toString();
                m_weChatAuthenticated = true;
                
                // Stop QR polling
                if (m_weChatQRTimer->isActive()) {
                    m_weChatQRTimer->stop();
                }
                
                saveCredentials(Provider::WeChat);
                setWeChatLoading(false);
                
                emit weChatAuthenticationChanged();
                emit authenticationSuccess(Provider::WeChat);
                
                // Fetch user info
                refreshUserInfo(Provider::WeChat);
                
                LoggingManager::instance()->debugGeneral("WeChat authentication successful");
            } else {
                QString error = response["errmsg"].toString();
                if (error.isEmpty()) {
                    error = "Failed to exchange auth code for access token";
                }
                emit authenticationError(Provider::WeChat, error);
                setWeChatLoading(false);
            }
        } else {
            emit authenticationError(Provider::WeChat, QString("Network error: %1").arg(reply->errorString()));
            setWeChatLoading(false);
        }
    });
}

void OAuth2Manager::exchangeDingTalkAuthCode(const QString &authCode)
{
    if (authCode.isEmpty() || m_dingTalkAppId.isEmpty() || m_dingTalkAppSecret.isEmpty()) {
        emit authenticationError(Provider::DingTalk, "Missing auth code or credentials");
        return;
    }
    
    QUrl url(DINGTALK_ACCESS_TOKEN_URL);
    
    QJsonObject requestData;
    requestData["client_id"] = m_dingTalkAppId;
    requestData["client_secret"] = m_dingTalkAppSecret;
    requestData["code"] = authCode;
    requestData["grant_type"] = "authorization_code";
    
    QJsonDocument doc(requestData);
    QByteArray data = doc.toJson();
    
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    request.setRawHeader("User-Agent", "VoiceAI-LLM/1.0");
    
    QNetworkReply *reply = m_networkManager->post(request, data);
    connect(reply, &QNetworkReply::finished, this, [this, reply]() {
        reply->deleteLater();
        
        if (reply->error() == QNetworkReply::NoError) {
            QJsonDocument doc = QJsonDocument::fromJson(reply->readAll());
            QJsonObject response = doc.object();
            
            if (response["errcode"].toInt() == 0) {
                m_dingTalkAccessToken = response["access_token"].toString();
                m_dingTalkRefreshToken = response["refresh_token"].toString();
                m_dingTalkUserId = response["userid"].toString();
                m_dingTalkAuthenticated = true;
                
                // Stop QR polling
                if (m_dingTalkQRTimer->isActive()) {
                    m_dingTalkQRTimer->stop();
                }
                
                saveCredentials(Provider::DingTalk);
                setDingTalkLoading(false);
                
                emit dingTalkAuthenticationChanged();
                emit authenticationSuccess(Provider::DingTalk);
                
                // Fetch user info
                refreshUserInfo(Provider::DingTalk);
                
                LoggingManager::instance()->debugGeneral("DingTalk authentication successful");
            } else {
                QString error = response["errmsg"].toString();
                if (error.isEmpty()) {
                    error = "Failed to exchange auth code for access token";
                }
                emit authenticationError(Provider::DingTalk, error);
                setDingTalkLoading(false);
            }
        } else {
            emit authenticationError(Provider::DingTalk, QString("Network error: %1").arg(reply->errorString()));
            setDingTalkLoading(false);
        }
    });
}

void OAuth2Manager::onWeChatQRCodeReceived(QNetworkReply *reply)
{
    reply->deleteLater();
    setWeChatLoading(false);
    
    if (reply->error() != QNetworkReply::NoError) {
        emit authenticationError(Provider::WeChat, QString("Failed to get QR code: %1").arg(reply->errorString()));
        return;
    }
    
    QJsonDocument doc = QJsonDocument::fromJson(reply->readAll());
    if (doc.isObject()) {
        QJsonObject response = doc.object();
        if (response.contains("errcode") && response["errcode"].toInt() != 0) {
            emit authenticationError(Provider::WeChat, response["errmsg"].toString());
        } else {
            m_weChatQRCodeTicket = response["ticket"].toString();
            QString qrUrl = response["url"].toString();
            
            if (!qrUrl.isEmpty()) {
                // Generate QR code from URL
                m_weChatQRCode = m_qrGenerator->generateQRCodeDataURI(qrUrl, 256);
                emit weChatQRCodeChanged();
                
                // Start polling for QR code status
                startQRCodePolling(Provider::WeChat);
                
                LoggingManager::instance()->debugGeneral("WeChat QR code generated");
            }
        }
    }
}

void OAuth2Manager::onDingTalkQRCodeReceived(QNetworkReply *reply)
{
    reply->deleteLater();
    setDingTalkLoading(false);
    
    if (reply->error() != QNetworkReply::NoError) {
        emit authenticationError(Provider::DingTalk, QString("Failed to get QR code: %1").arg(reply->errorString()));
        return;
    }
    
    QJsonDocument doc = QJsonDocument::fromJson(reply->readAll());
    if (doc.isObject()) {
        QJsonObject response = doc.object();
        if (response["errcode"].toInt() != 0) {
            emit authenticationError(Provider::DingTalk, response["errmsg"].toString());
        } else {
            m_dingTalkQRCodeKey = response["key"].toString();
            QString qrUrl = response["qr_url"].toString();
            
            if (!qrUrl.isEmpty()) {
                // Generate QR code from URL
                m_dingTalkQRCode = m_qrGenerator->generateQRCodeDataURI(qrUrl, 256);
                emit dingTalkQRCodeChanged();
                
                // Start polling for QR code status
                startQRCodePolling(Provider::DingTalk);
                
                LoggingManager::instance()->debugGeneral("DingTalk QR code generated");
            }
        }
    }
}

void OAuth2Manager::onWeChatAuthResult(QNetworkReply *reply)
{
    reply->deleteLater();
    
    if (reply->error() != QNetworkReply::NoError) {
        emit authenticationError(Provider::WeChat, QString("Authentication failed: %1").arg(reply->errorString()));
        setWeChatLoading(false);
        return;
    }
    
    QJsonDocument doc = QJsonDocument::fromJson(reply->readAll());
    if (doc.isObject()) {
        QJsonObject response = doc.object();
        if (response.contains("access_token")) {
            m_weChatAccessToken = response["access_token"].toString();
            m_weChatRefreshToken = response["refresh_token"].toString();
            m_weChatOpenId = response["openid"].toString();
            m_weChatAuthenticated = true;
            
            saveCredentials(Provider::WeChat);
            setWeChatLoading(false);
            
            emit weChatAuthenticationChanged();
            emit authenticationSuccess(Provider::WeChat);
            
            refreshUserInfo(Provider::WeChat);
            LoggingManager::instance()->debugGeneral("WeChat OAuth authentication successful");
        } else {
            emit authenticationError(Provider::WeChat, response["error_description"].toString());
            setWeChatLoading(false);
        }
    }
}

void OAuth2Manager::onDingTalkAuthResult(QNetworkReply *reply)
{
    reply->deleteLater();
    
    if (reply->error() != QNetworkReply::NoError) {
        emit authenticationError(Provider::DingTalk, QString("Authentication failed: %1").arg(reply->errorString()));
        setDingTalkLoading(false);
        return;
    }
    
    QJsonDocument doc = QJsonDocument::fromJson(reply->readAll());
    if (doc.isObject()) {
        QJsonObject response = doc.object();
        if (response["errcode"].toInt() == 0) {
            m_dingTalkAccessToken = response["access_token"].toString();
            m_dingTalkRefreshToken = response["refresh_token"].toString();
            m_dingTalkUserId = response["userid"].toString();
            m_dingTalkAuthenticated = true;
            
            saveCredentials(Provider::DingTalk);
            setDingTalkLoading(false);
            
            emit dingTalkAuthenticationChanged();
            emit authenticationSuccess(Provider::DingTalk);
            
            refreshUserInfo(Provider::DingTalk);
            LoggingManager::instance()->debugGeneral("DingTalk OAuth authentication successful");
        } else {
            emit authenticationError(Provider::DingTalk, response["errmsg"].toString());
            setDingTalkLoading(false);
        }
    }
}

void OAuth2Manager::startQRCodePolling(Provider provider)
{
    if (provider == Provider::WeChat) {
        if (m_weChatQRTimer) {
            m_weChatQRTimer->start();
            qDebug() << "Started WeChat QR code polling";
        }
    } else if (provider == Provider::DingTalk) {
        if (m_dingTalkQRTimer) {
            m_dingTalkQRTimer->start();
            qDebug() << "Started DingTalk QR code polling";
        }
    }
}

void OAuth2Manager::stopQRCodePolling(Provider provider)
{
    if (provider == Provider::WeChat) {
        if (m_weChatQRTimer && m_weChatQRTimer->isActive()) {
            m_weChatQRTimer->stop();
            qDebug() << "Stopped WeChat QR code polling";
        }
    } else if (provider == Provider::DingTalk) {
        if (m_dingTalkQRTimer && m_dingTalkQRTimer->isActive()) {
            m_dingTalkQRTimer->stop();
            qDebug() << "Stopped DingTalk QR code polling";
        }
    }
}

void OAuth2Manager::checkQRCodeStatusTimer()
{
    // Check status for both providers if they have active QR codes
    if (!m_weChatQRCode.isEmpty() && m_weChatQRTimer->isActive()) {
        checkQRCodeStatus(Provider::WeChat);
    }
    
    if (!m_dingTalkQRCode.isEmpty() && m_dingTalkQRTimer->isActive()) {
        checkQRCodeStatus(Provider::DingTalk);
    }
} 