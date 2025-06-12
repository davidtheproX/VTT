#pragma once

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QTimer>
#include <QJsonDocument>
#include <QJsonObject>
#include <QUrl>
#include <QOAuth2AuthorizationCodeFlow>
#include <QOAuthHttpServerReplyHandler>
#include <QOAuthUriSchemeReplyHandler>
#include <QtQmlIntegration>
#include <memory>

class QRCodeGenerator;

class OAuth2Manager : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    
    Q_PROPERTY(bool isWeChatAuthenticated READ isWeChatAuthenticated NOTIFY weChatAuthenticationChanged)
    Q_PROPERTY(bool isDingTalkAuthenticated READ isDingTalkAuthenticated NOTIFY dingTalkAuthenticationChanged)
    Q_PROPERTY(QString weChatUserInfo READ weChatUserInfo NOTIFY weChatUserInfoChanged)
    Q_PROPERTY(QString dingTalkUserInfo READ dingTalkUserInfo NOTIFY dingTalkUserInfoChanged)
    Q_PROPERTY(QString weChatQRCode READ weChatQRCode NOTIFY weChatQRCodeChanged)
    Q_PROPERTY(QString dingTalkQRCode READ dingTalkQRCode NOTIFY dingTalkQRCodeChanged)
    Q_PROPERTY(bool isWeChatLoading READ isWeChatLoading NOTIFY weChatLoadingChanged)
    Q_PROPERTY(bool isDingTalkLoading READ isDingTalkLoading NOTIFY dingTalkLoadingChanged)

public:
    enum class Provider {
        WeChat,
        DingTalk
    };
    Q_ENUM(Provider)
    
    enum class AuthMethod {
        QRCode,
        OAuth2Flow
    };
    Q_ENUM(AuthMethod)

    explicit OAuth2Manager(QObject *parent = nullptr);
    ~OAuth2Manager();

    // Property getters
    bool isWeChatAuthenticated() const { return m_weChatAuthenticated; }
    bool isDingTalkAuthenticated() const { return m_dingTalkAuthenticated; }
    QString weChatUserInfo() const { return m_weChatUserInfo; }
    QString dingTalkUserInfo() const { return m_dingTalkUserInfo; }
    QString weChatQRCode() const { return m_weChatQRCode; }
    QString dingTalkQRCode() const { return m_dingTalkQRCode; }
    bool isWeChatLoading() const { return m_weChatLoading; }
    bool isDingTalkLoading() const { return m_dingTalkLoading; }

public slots:
    // Configuration
    void setWeChatCredentials(const QString &appId, const QString &appSecret);
    void setDingTalkCredentials(const QString &appId, const QString &appSecret);
    
    // Authentication methods
    void authenticateWeChat(AuthMethod method = AuthMethod::QRCode);
    void authenticateDingTalk(AuthMethod method = AuthMethod::QRCode);
    
    // QR Code specific methods
    void refreshWeChatQRCode();
    void refreshDingTalkQRCode();
    void checkQRCodeStatus(Provider provider);
    
    // OAuth2 Flow specific methods
    void startWeChatOAuth();
    void startDingTalkOAuth();
    
    // User info
    void refreshUserInfo(Provider provider);
    
    // Logout
    void logoutWeChat();
    void logoutDingTalk();
    void logoutAll();

signals:
    void weChatAuthenticationChanged();
    void dingTalkAuthenticationChanged();
    void weChatUserInfoChanged();
    void dingTalkUserInfoChanged();
    void weChatQRCodeChanged();
    void dingTalkQRCodeChanged();
    void weChatLoadingChanged();
    void dingTalkLoadingChanged();
    void authenticationError(Provider provider, const QString &error);
    void authenticationSuccess(Provider provider);

private slots:
    void onWeChatQRCodeReceived(QNetworkReply *reply);
    void onDingTalkQRCodeReceived(QNetworkReply *reply);
    void onWeChatAuthResult(QNetworkReply *reply);
    void onDingTalkAuthResult(QNetworkReply *reply);
    void onWeChatUserInfoReceived(QNetworkReply *reply);
    void onDingTalkUserInfoReceived(QNetworkReply *reply);
    void checkQRCodeStatusTimer();

private:
    // Helper methods
    void initializeNetworkManager();
    void setupWeChatOAuth();
    void setupDingTalkOAuth();
    void generateQRCode(Provider provider);
    void startQRCodePolling(Provider provider);
    void stopQRCodePolling(Provider provider);
    void setWeChatLoading(bool loading);
    void setDingTalkLoading(bool loading);
    QString generateRandomState() const;
    void saveCredentials(Provider provider);
    void loadCredentials(Provider provider);
    void clearCredentials(Provider provider);
    void exchangeWeChatAuthCode(const QString &authCode);
    void exchangeDingTalkAuthCode(const QString &authCode);
    
    // Network
    QNetworkAccessManager *m_networkManager;
    
    // OAuth2 flows
    std::unique_ptr<QOAuth2AuthorizationCodeFlow> m_weChatOAuth;
    std::unique_ptr<QOAuth2AuthorizationCodeFlow> m_dingTalkOAuth;
    std::unique_ptr<QOAuthHttpServerReplyHandler> m_weChatReplyHandler;
    std::unique_ptr<QOAuthHttpServerReplyHandler> m_dingTalkReplyHandler;
    
    // QR Code generator
    QRCodeGenerator *m_qrGenerator;
    
    // Timers for QR code polling
    QTimer *m_weChatQRTimer;
    QTimer *m_dingTalkQRTimer;
    
    // WeChat configuration
    QString m_weChatAppId;
    QString m_weChatAppSecret;
    QString m_weChatQRCodeTicket;
    QString m_weChatAccessToken;
    QString m_weChatRefreshToken;
    QString m_weChatOpenId;
    
    // DingTalk configuration
    QString m_dingTalkAppId;
    QString m_dingTalkAppSecret;
    QString m_dingTalkQRCodeKey;
    QString m_dingTalkAccessToken;
    QString m_dingTalkRefreshToken;
    QString m_dingTalkUserId;
    
    // State
    bool m_weChatAuthenticated;
    bool m_dingTalkAuthenticated;
    bool m_weChatLoading;
    bool m_dingTalkLoading;
    QString m_weChatUserInfo;
    QString m_dingTalkUserInfo;
    QString m_weChatQRCode;
    QString m_dingTalkQRCode;
    
    // Constants
    static constexpr int QR_CODE_REFRESH_INTERVAL = 30000; // 30 seconds
    static constexpr int QR_CODE_CHECK_INTERVAL = 2000;    // 2 seconds
    static constexpr int OAUTH_SERVER_PORT = 8080;
    
    // API endpoints
    static const QString WECHAT_QR_URL;
    static const QString WECHAT_CHECK_QR_URL;
    static const QString WECHAT_ACCESS_TOKEN_URL;
    static const QString WECHAT_USER_INFO_URL;
    static const QString WECHAT_OAUTH_URL;
    
    static const QString DINGTALK_QR_URL;
    static const QString DINGTALK_CHECK_QR_URL;
    static const QString DINGTALK_ACCESS_TOKEN_URL;
    static const QString DINGTALK_USER_INFO_URL;
    static const QString DINGTALK_OAUTH_URL;
}; 