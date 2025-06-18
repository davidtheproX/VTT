#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QFile>
#include <QUrl>
#include <QCoreApplication>
#include <QtWebView/QtWebView>
#include <QTextToSpeech>
#include <QVoice>

// Windows console allocation for debugging
#ifdef Q_OS_WIN
#include <Windows.h>
#include <iostream>
#include <io.h>
#include <fcntl.h>
#endif

// Manager includes
#include "VoiceRecognitionManager.h"
#include "LLMConnectionManager.h"
#include "ChatManager.h"
#include "DatabaseManager.h"
#include "PromptManager.h"
#include "SecureStorageManager.h"
#include "LoggingManager.h"
#include "OAuth2Manager.h"
#include "QRCodeGenerator.h"
#include "PDFManager.h"
#include "CSVViewer.h"
#include "SvgHandler.h"
#include "DeviceDiscoveryManager.h"
#include "TTSManager.h"

int main(int argc, char *argv[])
{
    try {
#ifdef Q_OS_WIN
        // Allocate a console window for debugging output on Windows
        if (AllocConsole()) {
            freopen_s((FILE**)stdout, "CONOUT$", "w", stdout);
            freopen_s((FILE**)stderr, "CONOUT$", "w", stderr);
            freopen_s((FILE**)stdin, "CONIN$", "r", stdin);
            
            // Make cout, wcout, cin, wcin, wcerr, cerr, wclog and clog
            // point to console as well
            std::ios::sync_with_stdio(true);
            
            // Set console title
            SetConsoleTitle(L"VoiceAILLM Debug Console");
            
            std::cout << "Debug console allocated for VoiceAILLM" << std::endl;
            std::cout << "Console output will appear here" << std::endl;
        }
#endif

        // Initialize QtWebView before creating QGuiApplication (required by Qt WebView)
        QtWebView::initialize();

        // Enable high DPI scaling support before creating QGuiApplication
        QGuiApplication::setHighDpiScaleFactorRoundingPolicy(Qt::HighDpiScaleFactorRoundingPolicy::PassThrough);

        QGuiApplication app(argc, argv);

        app.setApplicationName("Voice AI LLM");
        app.setOrganizationName("VoiceAILLM");
        app.setApplicationDisplayName("Voice AI LLM Assistant");

        // Initialize logging first
        LoggingManager* logger = LoggingManager::instance();
        logger->initializeLogging();
        logger->infoGeneral("Application starting up");

        // Initialize secure storage
        SecureStorageManager secureStorage;
        logger->infoSecurity(QString("Secure storage available: %1")
                                 .arg(secureStorage.isSecureStorageAvailable() ? "Yes" : "No (using fallback)"));

        // Initialize managers
        logger->infoDatabase("Initializing database manager");
        DatabaseManager dbManager;
        try {
            if (!dbManager.initialize()) {
                logger->criticalDatabase("Failed to initialize database");
            } else {
                logger->infoDatabase("Database manager initialized successfully");
            }
        } catch (...) {
            logger->criticalDatabase("Database initialization exception");
        }

        logger->infoVoice("Initializing voice recognition manager");
        VoiceRecognitionManager voiceManager;

        logger->infoLLM("Initializing LLM connection manager");
        LLMConnectionManager llmManager;

        logger->infoGeneral("Initializing OAuth2 manager");
        OAuth2Manager oauth2Manager;

        logger->infoGeneral("Initializing PDF manager");
        PDFManager pdfManager;

        logger->infoGeneral("Initializing CSV viewer");
        CSVViewer csvViewer;

        logger->infoGeneral("Initializing device discovery manager");
        DeviceDiscoveryManager deviceDiscoveryManager;

        logger->infoGeneral("Initializing TTS manager");
        TTSManager ttsManager;

        logger->infoGeneral("Initializing chat manager");
        ChatManager chatManager(&llmManager);
        chatManager.setDatabaseManager(&dbManager);

        logger->infoDatabase("Initializing prompt manager");
        PromptManager promptManager(&dbManager);
        logger->infoGeneral("All managers initialized successfully");

        // Load and apply saved settings with secure storage
        logger->infoSecurity("Loading settings with secure credential handling");

        QJsonObject settings = dbManager.getSettings();
        if (!settings.isEmpty() && settings.contains("ai")) {
            QJsonObject aiSettings = settings["ai"].toObject();
            if (!aiSettings.isEmpty()) {
                logger->infoLLM("Applying AI settings from secure storage");

                // Apply AI settings
                if (aiSettings.contains("provider")) {
                    llmManager.setCurrentProvider(static_cast<LLMConnectionManager::Provider>(aiSettings["provider"].toInt()));
                }
                if (aiSettings.contains("baseUrl")) {
                    llmManager.setBaseUrl(aiSettings["baseUrl"].toString());
                }

                // Load API key from secure storage instead of database
                QString apiKey = secureStorage.retrieveCredential("openai_api_key");
                if (!apiKey.isEmpty()) {
                    llmManager.setApiKey(apiKey);
                    logger->infoSecurity("OpenAI API key loaded from secure storage");
                } else if (aiSettings.contains("apiKey")) {
                    // Migrate from old insecure storage
                    QString oldApiKey = aiSettings["apiKey"].toString();
                    if (!oldApiKey.isEmpty()) {
                        secureStorage.storeCredential("openai_api_key", oldApiKey);
                        llmManager.setApiKey(oldApiKey);
                        logger->warningSecurity("Migrated API key from insecure to secure storage");
                    }
                }

                if (aiSettings.contains("model")) {
                    llmManager.setModel(aiSettings["model"].toString());
                }

                // Note: Auto-testing is handled by the settings dialog when opened
            }
        }

        // Apply voice settings with secure storage
        if (settings.contains("voice")) {
            QJsonObject voiceSettings = settings["voice"].toObject();

            // Load Google API key from secure storage
            QString googleApiKey = secureStorage.retrieveCredential("google_speech_api_key");
            if (!googleApiKey.isEmpty()) {
                voiceManager.setGoogleApiKey(googleApiKey);
                logger->infoSecurity("Google Speech API key loaded from secure storage");
            } else if (voiceSettings.contains("googleApiKey")) {
                // Migrate from old insecure storage
                QString oldGoogleApiKey = voiceSettings["googleApiKey"].toString();
                if (!oldGoogleApiKey.isEmpty()) {
                    secureStorage.storeCredential("google_speech_api_key", oldGoogleApiKey);
                    voiceManager.setGoogleApiKey(oldGoogleApiKey);
                    logger->warningSecurity("Migrated Google API key from insecure to secure storage");
                }
            }
        }

        // Connect signals
        logger->infoGeneral("Connecting manager signals");
        QObject::connect(&voiceManager, &VoiceRecognitionManager::textRecognized,
                         &chatManager, &ChatManager::processUserInput);

        QQmlApplicationEngine engine;
        logger->infoUI("QML application engine created");

        // Register the C++ QTextToSpeech enums so they can be used in QML
        qmlRegisterUncreatableType<QTextToSpeech>("QtTextToSpeech", 1, 0, "TextToSpeech", "Cannot create TextToSpeech in QML");
        qmlRegisterUncreatableType<QVoice>("QtTextToSpeech", 1, 0, "Voice", "Cannot create Voice in QML");

        // Set context properties for QML
        engine.rootContext()->setContextProperty("voiceManager", &voiceManager);
        engine.rootContext()->setContextProperty("chatManager", &chatManager);
        engine.rootContext()->setContextProperty("llmManager", &llmManager);
        engine.rootContext()->setContextProperty("promptManager", &promptManager);
        engine.rootContext()->setContextProperty("databaseManager", &dbManager);
        engine.rootContext()->setContextProperty("oauth2Manager", &oauth2Manager);
        engine.rootContext()->setContextProperty("pdfManager", &pdfManager);
        engine.rootContext()->setContextProperty("csvViewer", &csvViewer);
        engine.rootContext()->setContextProperty("deviceDiscoveryManager", &deviceDiscoveryManager);
        engine.rootContext()->setContextProperty("ttsManager", &ttsManager);

        // Register QML types
        qmlRegisterType<CSVViewer>("VoiceAILLM", 1, 0, "CSVViewerBackend");
        qmlRegisterType<SvgHandler>("VoiceAILLM", 1, 0, "SvgHandler");
        qmlRegisterModule("QtSvg", 6, 9);

        // Load the main QML file

#ifdef Q_OS_ANDROID
        QUrl url(QStringLiteral("qrc:/qt/qml/VoiceAILLM/qml/Main.qml"));
        if (!QFile::exists(":qt/qml/VoiceAILLM/qml/Main.qml")) {
            url = QUrl::fromLocalFile(QCoreApplication::applicationDirPath() + "/../qml/Main.qml");
#else
        QUrl url(QStringLiteral("qrc:/VoiceAILLM/qml/Main.qml"));
        if (!QFile::exists(":/VoiceAILLM/qml/Main.qml")) {
            url = QUrl::fromLocalFile(QCoreApplication::applicationDirPath() + "/../qml/Main.qml");
#endif
        }
        QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                         &app, [url](QObject *obj, const QUrl &objUrl) {
                             if (!obj && url == objUrl) {
                                 QCoreApplication::exit(-1);
                             }
                         }, Qt::QueuedConnection);

        engine.load(url);

        if (engine.rootObjects().isEmpty()) {
            return -1;
        }

        // Set ttsManager context property from the main window's TTSComponent
        QObject *mainWindow = engine.rootObjects().first();
        if (mainWindow) {
            QObject *ttsComponent = mainWindow->findChild<QObject*>("ttsComponent");
            if (ttsComponent) {
                engine.rootContext()->setContextProperty("ttsManager", ttsComponent);
            }
        }

        logger->infoGeneral("Application initialization complete, starting main event loop");

        return app.exec();

    } catch (...) {
        if (LoggingManager::instance()) {
            LoggingManager::instance()->criticalGeneral("Application startup failed");
        }
        return -1;
    }
}
