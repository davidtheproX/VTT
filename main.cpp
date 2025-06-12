#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QTimer>
#include <QFile>
#include <iostream>
#include <stdexcept>

// Manager includes
#include "VoiceRecognitionManager.h"
#include "LLMConnectionManager.h"
#include "ChatManager.h"
#include "DatabaseManager.h"
#include "TTSManager.h"
#include "PromptManager.h"
#include "SecureStorageManager.h"
#include "LoggingManager.h"
#include "OAuth2Manager.h"
#include "QRCodeGenerator.h"
#include "PDFManager.h"
#include "CSVViewer.h"

#ifdef _WIN32
#include <Windows.h>
#include <io.h>
#include <fcntl.h>
#include <cstdio>
#endif

int main(int argc, char *argv[])
{
#ifdef _WIN32
    // Allocate a console for this GUI application
    AllocConsole();
    
    // Redirect stdout, stdin, stderr to console
    freopen_s((FILE**)stdout, "CONOUT$", "w", stdout);
    freopen_s((FILE**)stderr, "CONOUT$", "w", stderr);
    freopen_s((FILE**)stdin, "CONIN$", "r", stdin);
    
    // Make cout, wcout, cin, wcin, wcerr, cerr, wclog and clog point to console as well
    std::ios::sync_with_stdio(true);
    
    // Set console title
    SetConsoleTitle(L"VoiceAI LLM Debug Console");
#endif

    try {
        std::cout << "=== Starting Voice AI LLM application ===" << std::endl;
        std::cout.flush();
        
        // Enable high DPI scaling support before creating QGuiApplication
        QGuiApplication::setHighDpiScaleFactorRoundingPolicy(Qt::HighDpiScaleFactorRoundingPolicy::PassThrough);
        // Note: Qt::AA_UseHighDpiPixmaps is deprecated in Qt6.9 - high DPI pixmaps are enabled by default
        
        QGuiApplication app(argc, argv);
        std::cout << "=== QGuiApplication created ===" << std::endl;
        std::cout.flush();
        
        app.setApplicationName("Voice AI LLM");
        app.setOrganizationName("VoiceAILLM");
        app.setApplicationDisplayName("Voice AI LLM Assistant");
        std::cout << "=== App properties set ===" << std::endl;

        // Initialize logging first
        std::cout << "=== Initializing logging ===" << std::endl;
        LoggingManager* logger = LoggingManager::instance();
        logger->initializeLogging();
        logger->infoGeneral("Application starting up");

        // Initialize secure storage
        std::cout << "=== Initializing secure storage ===" << std::endl;
        SecureStorageManager secureStorage;
        logger->infoSecurity(QString("Secure storage available: %1")
                           .arg(secureStorage.isSecureStorageAvailable() ? "Yes" : "No (using fallback)"));

        // Initialize managers (DatabaseManager fixed for post-QApplication initialization)
        std::cout << "=== Initializing managers ===" << std::endl;
        logger->infoDatabase("Initializing database manager");
        DatabaseManager dbManager;
        try {
            if (!dbManager.initialize()) {
                std::cout << "WARNING: Failed to initialize database" << std::endl;
                logger->criticalDatabase("Failed to initialize database");
            } else {
                logger->infoDatabase("Database manager initialized successfully");
            }
        } catch (const std::exception &e) {
            std::cout << "ERROR: Database initialization exception: " << e.what() << std::endl;
            logger->criticalDatabase(QString("Database exception: %1").arg(e.what()));
        }
    
        logger->infoVoice("Initializing voice recognition manager");
        VoiceRecognitionManager voiceManager;
        
        logger->infoLLM("Initializing LLM connection manager");
        LLMConnectionManager llmManager;
        
        logger->infoGeneral("Initializing TTS manager");
        TTSManager ttsManager;
        
        logger->infoGeneral("Initializing OAuth2 manager");
        OAuth2Manager oauth2Manager;
        
        logger->infoGeneral("Initializing PDF manager");
        PDFManager pdfManager;
        
        logger->infoGeneral("Initializing CSV viewer");
        CSVViewer csvViewer;
        
        logger->infoGeneral("Initializing chat manager");
        ChatManager chatManager(&llmManager);
        chatManager.setDatabaseManager(&dbManager);
        chatManager.setTTSManager(&ttsManager);
        
        logger->infoDatabase("Initializing prompt manager");
        PromptManager promptManager(&dbManager);
        std::cout << "=== All managers created ===" << std::endl;
        logger->infoGeneral("All managers initialized successfully");
    
        // Load and apply saved settings with secure storage
        std::cout << "=== Loading saved settings ===" << std::endl;
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
                QString apiKey = secureStorage.getCredential("openai_api_key");
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
            QString googleApiKey = secureStorage.getCredential("google_speech_api_key");
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
        
        // Apply TTS settings
        if (settings.contains("tts")) {
            QJsonObject ttsSettings = settings["tts"].toObject();
            if (ttsSettings.contains("enabled")) {
                ttsManager.setIsEnabled(ttsSettings["enabled"].toBool());
            }
            if (ttsSettings.contains("voice")) {
                ttsManager.setCurrentVoice(ttsSettings["voice"].toString());
            }
            if (ttsSettings.contains("rate")) {
                ttsManager.setRate(ttsSettings["rate"].toDouble());
            }
            if (ttsSettings.contains("pitch")) {
                ttsManager.setPitch(ttsSettings["pitch"].toDouble());
            }
            if (ttsSettings.contains("volume")) {
                ttsManager.setVolume(ttsSettings["volume"].toDouble());
            }
        }

        // Connect signals
        logger->infoGeneral("Connecting manager signals");
        QObject::connect(&voiceManager, &VoiceRecognitionManager::textRecognized,
                         &chatManager, &ChatManager::processUserInput);

        QQmlApplicationEngine engine;
        std::cout << "=== QQmlApplicationEngine created ===" << std::endl;
        logger->infoUI("QML application engine created");
        
        // Set context properties for QML
        engine.rootContext()->setContextProperty("voiceManager", &voiceManager);
        engine.rootContext()->setContextProperty("chatManager", &chatManager);
        engine.rootContext()->setContextProperty("llmManager", &llmManager);
        engine.rootContext()->setContextProperty("ttsManager", &ttsManager);
        engine.rootContext()->setContextProperty("promptManager", &promptManager);
        engine.rootContext()->setContextProperty("databaseManager", &dbManager);
        engine.rootContext()->setContextProperty("oauth2Manager", &oauth2Manager);
        engine.rootContext()->setContextProperty("pdfManager", &pdfManager);
        engine.rootContext()->setContextProperty("csvViewer", &csvViewer);
        
        // Register QML types for CSV viewer
        qmlRegisterType<CSVViewer>("VoiceAILLM", 1, 0, "CSVViewerBackend");
        
        std::cout << "=== Context properties set ===" << std::endl;

        // Load the main QML file - try both resource and file system
        QUrl url(QStringLiteral("qrc:/VoiceAILLM/qml/Main.qml"));
        std::cout << "=== Trying QML resource: " << url.toString().toStdString() << " ===" << std::endl;
        
        // Fallback to file system if resource doesn't exist
        if (!QFile::exists(":/VoiceAILLM/qml/Main.qml")) {
            std::cout << "=== QML resource not found, trying file system ===" << std::endl;
            url = QUrl::fromLocalFile(QCoreApplication::applicationDirPath() + "/../qml/Main.qml");
            std::cout << "=== Using file: " << url.toString().toStdString() << " ===" << std::endl;
        }
        
        QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                         &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl) {
                std::cout << "ERROR: Failed to load QML file!" << std::endl;
                QCoreApplication::exit(-1);
            }
        }, Qt::QueuedConnection);
        
        std::cout << "=== Loading QML file: " << url.toString().toStdString() << " ===" << std::endl;
        engine.load(url);

        if (engine.rootObjects().isEmpty()) {
            std::cout << "=== ERROR: No root objects found ===" << std::endl;
            return -1;
        }

        std::cout << "=== Application loaded successfully, starting event loop ===" << std::endl;
        logger->infoGeneral("Application initialization complete, starting main event loop");
        
        return app.exec();
        
    } catch (const std::exception &e) {
        std::cerr << "ERROR: Application failed to start: " << e.what() << std::endl;
        if (LoggingManager::instance()) {
            LoggingManager::instance()->criticalGeneral(QString("Application startup failed: %1").arg(e.what()));
        }
        return -1;
    } catch (...) {
        std::cerr << "ERROR: Unknown error occurred during application startup" << std::endl;
        if (LoggingManager::instance()) {
            LoggingManager::instance()->criticalGeneral("Unknown error during application startup");
        }
        return -1;
    }
} 