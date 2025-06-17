#include "TTSManager.h"
#include <QDebug>
#include <QCoreApplication>

TTSManager::TTSManager(QObject *parent)
    : QObject(parent)
    , m_tts(nullptr)
    , m_settings(nullptr)
    , m_queueTimer(new QTimer(this))
    , m_rate(0.0)
    , m_pitch(0.0)
    , m_volume(0.7)
    , m_autoDetectLanguage(true)
    , m_isInitialized(false)
{
    // Initialize language detection patterns
    m_chinesePattern.setPattern(QStringLiteral("[\\u4e00-\\u9fff]"));
    m_japanesePattern.setPattern(QStringLiteral("[\\u3040-\\u309f\\u30a0-\\u30ff]"));
    m_koreanPattern.setPattern(QStringLiteral("[\\uac00-\\ud7af\\u1100-\\u11ff\\u3130-\\u318f]"));
    m_arabicPattern.setPattern(QStringLiteral("[\\u0600-\\u06ff\\u0750-\\u077f]"));
    m_russianPattern.setPattern(QStringLiteral("[\\u0400-\\u04ff]"));
    m_englishPattern.setPattern(QStringLiteral("[a-zA-Z]"));

    // Initialize settings
    m_settings = new QSettings("VoiceAILLM", "TTSManager", this);
    
    // Setup queue timer
    m_queueTimer->setSingleShot(true);
    connect(m_queueTimer, &QTimer::timeout, this, &TTSManager::processNextInQueue);
    
    // Initialize TTS
    initializeTTS();
    loadSettings();
}

TTSManager::~TTSManager()
{
    if (m_tts) {
        m_tts->stop();
    }
    saveSettings();
}

void TTSManager::initializeTTS()
{
    if (m_tts) {
        delete m_tts;
    }
    
    qDebug() << "TTS: Initializing TextToSpeech...";
    
    // List available engines first
    QStringList engines = QTextToSpeech::availableEngines();
    qDebug() << "TTS: Available engines:" << engines;
    
    if (engines.isEmpty()) {
        qWarning() << "TTS: No TTS engines available on this platform!";
        emit speechError("No TTS engines available on this platform");
        return;
    }
    
    // Try to create TTS with default engine first
    m_tts = new QTextToSpeech(this);
    
    qDebug() << "TTS: Created with engine:" << m_tts->engine();
    qDebug() << "TTS: Initial state:" << m_tts->state();
    
    // Connect signals
    connect(m_tts, &QTextToSpeech::stateChanged, this, &TTSManager::onStateChanged);
    connect(m_tts, QOverload<QTextToSpeech::ErrorReason, const QString &>::of(&QTextToSpeech::errorOccurred),
            this, &TTSManager::onErrorOccurred);
    
    // Check if TTS is in error state
    if (m_tts->state() == QTextToSpeech::Error) {
        qWarning() << "TTS: Engine failed to initialize!";
        
        // Try each available engine
        for (const QString &engine : engines) {
            qDebug() << "TTS: Trying engine:" << engine;
            delete m_tts;
            m_tts = new QTextToSpeech(engine, this);
            
            // Reconnect signals
            connect(m_tts, &QTextToSpeech::stateChanged, this, &TTSManager::onStateChanged);
            connect(m_tts, QOverload<QTextToSpeech::ErrorReason, const QString &>::of(&QTextToSpeech::errorOccurred),
                    this, &TTSManager::onErrorOccurred);
            
            qDebug() << "TTS: Engine" << engine << "state:" << m_tts->state();
            if (m_tts->state() != QTextToSpeech::Error) {
                qDebug() << "TTS: Successfully initialized with engine:" << engine;
                break;
            }
        }
    }
    
    // Final check
    if (m_tts->state() == QTextToSpeech::Error) {
        qCritical() << "TTS: All engines failed to initialize!";
        emit speechError("All TTS engines failed to initialize");
        return;
    }
    
    // Update available voices and languages
    updateAvailableVoices();
    updateSupportedLanguages();
    
    m_isInitialized = true;
    emit availabilityChanged(isAvailable());
    
    qDebug() << "TTS: Initialization complete. Available:" << isAvailable();
}

// Basic properties
bool TTSManager::isAvailable() const
{
    return m_tts && m_tts->state() != QTextToSpeech::Error && m_isInitialized;
}

bool TTSManager::isEnabled() const
{
    return m_isInitialized && isAvailable();
}

void TTSManager::setIsEnabled(bool enabled)
{
    if (enabled && !m_isInitialized) {
        initializeTTS();
    } else if (!enabled && m_isInitialized) {
        if (m_tts) {
            m_tts->stop();
        }
    }
    emit enabledChanged(enabled);
}

QString TTSManager::currentEngine() const
{
    return m_currentEngine;
}

QStringList TTSManager::availableEngines() const
{
    return QTextToSpeech::availableEngines();
}

QString TTSManager::currentVoice() const
{
    return m_currentVoice;
}

QString TTSManager::currentVoiceName() const
{
    if (m_tts) {
        QVoice voice = m_tts->voice();
        return voice.name();
    }
    return m_currentVoice;
}

QStringList TTSManager::availableVoiceNames() const
{
    return m_availableVoiceNames;
}

QVariantList TTSManager::getAvailableVoicesAsVariant() const
{
    QVariantList voiceList;
    if (!m_tts) return voiceList;
    
    QList<QLocale> locales = m_tts->availableLocales();
    for (const QLocale &locale : locales) {
        m_tts->setLocale(locale);
        QList<QVoice> voices = m_tts->availableVoices();
        
        for (const QVoice &voice : voices) {
            QVariantMap voiceMap;
            voiceMap["name"] = voice.name();
            voiceMap["locale"] = locale.name();
            voiceMap["gender"] = static_cast<int>(voice.gender());
            voiceMap["age"] = static_cast<int>(voice.age());
            voiceMap["displayName"] = voiceToString(voice);
            voiceList.append(voiceMap);
        }
    }
    
    return voiceList;
}

double TTSManager::rate() const
{
    return m_rate;
}

double TTSManager::pitch() const
{
    return m_pitch;
}

double TTSManager::volume() const
{
    return m_volume;
}

QString TTSManager::currentLanguage() const
{
    return m_currentLanguage;
}

QStringList TTSManager::supportedLanguages() const
{
    return m_supportedLanguages;
}

bool TTSManager::autoDetectLanguage() const
{
    return m_autoDetectLanguage;
}

bool TTSManager::isSpeaking() const
{
    return m_tts && m_tts->state() == QTextToSpeech::Speaking;
}

bool TTSManager::isPaused() const
{
    return m_tts && m_tts->state() == QTextToSpeech::Paused;
}

int TTSManager::queueSize() const
{
    return m_speechQueue.size();
}

// Engine and voice management
void TTSManager::setCurrentEngine(const QString &engine)
{
    if (m_currentEngine != engine) {
        m_currentEngine = engine;
        
        // Reinitialize with new engine
        if (m_tts) {
            delete m_tts;
        }
        m_tts = new QTextToSpeech(engine, this);
        
        // Reconnect signals
        connect(m_tts, &QTextToSpeech::stateChanged, this, &TTSManager::onStateChanged);
        connect(m_tts, QOverload<QTextToSpeech::ErrorReason, const QString &>::of(&QTextToSpeech::errorOccurred),
                this, &TTSManager::onErrorOccurred);
        
        updateAvailableVoices();
        updateSupportedLanguages();
        
        emit engineChanged(engine);
        emit enginesChanged();
    }
}

void TTSManager::setCurrentVoice(const QString &voiceName)
{
    if (m_currentVoice != voiceName) {
        QVoice voice = findVoiceByName(voiceName);
        if (!voice.name().isEmpty()) {
            m_tts->setVoice(voice);
            m_currentVoice = voiceName;
            emit voiceChanged(voiceName);
        }
    }
}

void TTSManager::setVoiceByIndex(int index)
{
    if (index >= 0 && index < m_availableVoiceNames.size()) {
        setCurrentVoice(m_availableVoiceNames[index]);
    }
}

void TTSManager::refreshVoices()
{
    updateAvailableVoices();
    updateSupportedLanguages();
}

// Speech parameters
void TTSManager::setRate(double rate)
{
    if (qAbs(m_rate - rate) > 0.01) {
        m_rate = rate;
        if (m_tts) {
            m_tts->setRate(rate);
        }
        emit rateChanged(rate);
    }
}

void TTSManager::setPitch(double pitch)
{
    if (qAbs(m_pitch - pitch) > 0.01) {
        m_pitch = pitch;
        if (m_tts) {
            m_tts->setPitch(pitch);
        }
        emit pitchChanged(pitch);
    }
}

void TTSManager::setVolume(double volume)
{
    if (qAbs(m_volume - volume) > 0.01) {
        m_volume = volume;
        if (m_tts) {
            m_tts->setVolume(volume);
        }
        emit volumeChanged(volume);
    }
}

// Language management
void TTSManager::setCurrentLanguage(const QString &language)
{
    if (m_currentLanguage != language) {
        m_currentLanguage = language;
        
        // Find and set best voice for this language
        QVoice bestVoice = findBestVoiceForLanguage(language);
        if (!bestVoice.name().isEmpty()) {
            m_tts->setVoice(bestVoice);
            m_currentVoice = voiceToString(bestVoice);
            emit voiceChanged(m_currentVoice);
        }
        
        emit languageChanged(language);
    }
}

void TTSManager::setAutoDetectLanguage(bool autoDetect)
{
    if (m_autoDetectLanguage != autoDetect) {
        m_autoDetectLanguage = autoDetect;
        emit autoDetectChanged(autoDetect);
    }
}

QString TTSManager::detectLanguage(const QString &text)
{
    if (text.isEmpty()) {
        return QStringLiteral("en");
    }
    
    // Check for Chinese (including Traditional and Simplified)
    if (m_chinesePattern.match(text).hasMatch()) {
        return detectChineseDialect(text);
    }
    
    // Check for Japanese
    if (m_japanesePattern.match(text).hasMatch()) {
        return detectJapanese(text);
    }
    
    // Check for Korean
    if (m_koreanPattern.match(text).hasMatch()) {
        return detectKorean(text);
    }
    
    // Check for Arabic
    if (m_arabicPattern.match(text).hasMatch()) {
        return detectArabic(text);
    }
    
    // Check for Russian
    if (m_russianPattern.match(text).hasMatch()) {
        return detectRussian(text);
    }
    
    // Default to English if mostly Latin characters
    if (isEnglish(text)) {
        return QStringLiteral("en");
    }
    
    // Default fallback
    return QStringLiteral("en");
}

// Main TTS functions - Detect -> Query -> Set -> Speak pattern
void TTSManager::speak(const QString &text)
{
    if (!isAvailable() || text.isEmpty()) {
        return;
    }
    
    QString language = m_currentLanguage;
    
    // Step 1: Detect language if auto-detection is enabled
    if (m_autoDetectLanguage) {
        QString detectedLang = detectLanguage(text);
        if (!detectedLang.isEmpty()) {
            language = detectedLang;
            emit languageDetected(detectedLang);
        }
    }
    
    // Step 2: Query and Set appropriate voice for the language
    if (language != m_currentLanguage) {
        setCurrentLanguage(language);
    }
    
    // Step 3: Speak
    speakWithSettings(text, language, m_rate, m_pitch, m_volume);
}

void TTSManager::speakWithLanguage(const QString &text, const QString &language)
{
    if (!isAvailable() || text.isEmpty()) {
        return;
    }
    
    // Set language and voice
    if (language != m_currentLanguage) {
        setCurrentLanguage(language);
    }
    
    speakWithSettings(text, language, m_rate, m_pitch, m_volume);
}

void TTSManager::speakWithSettings(const QString &text, const QString &language, double rate, double pitch, double volume)
{
    if (!isAvailable() || text.isEmpty()) {
        return;
    }
    
    // Apply settings
    setRate(rate);
    setPitch(pitch);
    setVolume(volume);
    
    if (language != m_currentLanguage) {
        setCurrentLanguage(language);
    }
    
    // Speak immediately
    m_tts->say(text);
    emit speechStarted();
}

// Queue management
void TTSManager::addToQueue(const QString &text)
{
    if (!text.isEmpty()) {
        SpeechRequest request;
        request.text = text;
        request.language = m_autoDetectLanguage ? detectLanguage(text) : m_currentLanguage;
        request.rate = m_rate;
        request.pitch = m_pitch;
        request.volume = m_volume;
        
        m_speechQueue.enqueue(request);
        emit queueSizeChanged(m_speechQueue.size());
        
        // Start processing if not currently speaking
        if (!isSpeaking()) {
            processNextInQueue();
        }
    }
}

void TTSManager::addToQueueWithLanguage(const QString &text, const QString &language)
{
    if (!text.isEmpty()) {
        SpeechRequest request;
        request.text = text;
        request.language = language;
        request.rate = m_rate;
        request.pitch = m_pitch;
        request.volume = m_volume;
        
        m_speechQueue.enqueue(request);
        emit queueSizeChanged(m_speechQueue.size());
        
        // Start processing if not currently speaking
        if (!isSpeaking()) {
            processNextInQueue();
        }
    }
}

void TTSManager::clearQueue()
{
    m_speechQueue.clear();
    emit queueSizeChanged(0);
}

void TTSManager::skipCurrent()
{
    if (isSpeaking()) {
        m_tts->stop();
    }
    processNextInQueue();
}

// Playback control
void TTSManager::pause()
{
    if (m_tts && isSpeaking()) {
        m_tts->pause();
    }
}

void TTSManager::resume()
{
    if (m_tts && isPaused()) {
        m_tts->resume();
    }
}

void TTSManager::stop()
{
    if (m_tts) {
        m_tts->stop();
    }
    clearQueue();
}

// Settings persistence
void TTSManager::saveSettings()
{
    if (!m_settings) return;
    
    m_settings->setValue("currentEngine", m_currentEngine);
    m_settings->setValue("currentVoice", m_currentVoice);
    m_settings->setValue("currentLanguage", m_currentLanguage);
    m_settings->setValue("rate", m_rate);
    m_settings->setValue("pitch", m_pitch);
    m_settings->setValue("volume", m_volume);
    m_settings->setValue("autoDetectLanguage", m_autoDetectLanguage);
    m_settings->sync();
}

void TTSManager::loadSettings()
{
    if (!m_settings) return;
    
    m_currentEngine = m_settings->value("currentEngine", "").toString();
    m_currentVoice = m_settings->value("currentVoice", "").toString();
    m_currentLanguage = m_settings->value("currentLanguage", "en").toString();
    m_rate = m_settings->value("rate", 0.0).toDouble();
    m_pitch = m_settings->value("pitch", 0.0).toDouble();
    m_volume = m_settings->value("volume", 0.7).toDouble();
    m_autoDetectLanguage = m_settings->value("autoDetectLanguage", true).toBool();
    
    applyStoredSettings();
}

void TTSManager::resetToDefaults()
{
    m_currentEngine = "";
    m_currentVoice = "";
    m_currentLanguage = "en";
    m_rate = 0.0;
    m_pitch = 0.0;
    m_volume = 0.7;
    m_autoDetectLanguage = true;
    
    applyStoredSettings();
    saveSettings();
}

// Private slots
void TTSManager::onStateChanged(QTextToSpeech::State state)
{
    emit speakingChanged(state == QTextToSpeech::Speaking);
    emit pausedChanged(state == QTextToSpeech::Paused);
    
    if (state == QTextToSpeech::Ready) {
        emit speechFinished();
        
        // Process next item in queue after a short delay
        if (!m_speechQueue.isEmpty()) {
            m_queueTimer->start(100);
        }
    }
}

void TTSManager::onErrorOccurred(QTextToSpeech::ErrorReason reason, const QString &errorString)
{
    Q_UNUSED(reason)
    emit speechError(errorString);
    qWarning() << "TTS Error:" << errorString;
}

void TTSManager::processNextInQueue()
{
    if (m_speechQueue.isEmpty() || isSpeaking()) {
        return;
    }
    
    SpeechRequest request = m_speechQueue.dequeue();
    emit queueSizeChanged(m_speechQueue.size());
    
    speakWithSettings(request.text, request.language, request.rate, request.pitch, request.volume);
}

// Private helper methods
void TTSManager::updateAvailableVoices()
{
    if (!m_tts) {
        qWarning() << "TTS: Cannot update voices - TTS object is null!";
        return;
    }
    
    qDebug() << "TTS: Updating available voices...";
    qDebug() << "TTS: Current engine:" << m_tts->engine();
    qDebug() << "TTS: Current state:" << m_tts->state();
    
    m_availableVoiceNames.clear();
    
    // Get all available locales first
    QList<QLocale> locales = m_tts->availableLocales();
    qDebug() << "TTS: Found" << locales.size() << "locales";
    
    if (locales.isEmpty()) {
        qWarning() << "TTS: No locales available! This indicates a TTS engine problem.";
        emit speechError("No locales available from TTS engine");
        return;
    }
    
    // Debug: Show all locales
    for (int i = 0; i < qMin(locales.size(), 10); ++i) {
        const QLocale &locale = locales[i];
        qDebug() << "TTS: Locale" << i << ":" << locale.name() << "(" << locale.nativeLanguageName() << ")";
    }
    
    // For each locale, get the available voices
    int totalVoices = 0;
    for (const QLocale &locale : locales) {
        m_tts->setLocale(locale);
        QList<QVoice> voices = m_tts->availableVoices();
        
        qDebug() << "TTS: Locale" << locale.name() << "has" << voices.size() << "voices";
        
        for (const QVoice &voice : voices) {
            QString voiceString = QString("%1 [%2] (%3, %4)")
                .arg(voice.name())
                .arg(locale.nativeLanguageName())
                .arg(QVoice::genderName(voice.gender()))
                .arg(QVoice::ageName(voice.age()));
            
            if (!m_availableVoiceNames.contains(voiceString)) {
                m_availableVoiceNames.append(voiceString);
                totalVoices++;
                
                // Debug first few voices
                if (totalVoices <= 5) {
                    qDebug() << "TTS: Voice" << totalVoices << ":" << voiceString;
                }
            }
        }
    }
    
    qDebug() << "TTS: Final result:" << m_availableVoiceNames.size() << "unique voices across" << locales.size() << "locales";
    
    if (m_availableVoiceNames.isEmpty()) {
        qWarning() << "TTS: No voices found! This is a serious TTS configuration issue.";
        
        // Try a simpler approach - get voices for current locale only
        QList<QVoice> defaultVoices = m_tts->availableVoices();
        qDebug() << "TTS: Trying default locale, found" << defaultVoices.size() << "voices";
        
        for (const QVoice &voice : defaultVoices) {
            QString voiceString = QString("%1 (Default)")
                .arg(voice.name());
            m_availableVoiceNames.append(voiceString);
            qDebug() << "TTS: Default voice:" << voiceString;
        }
    }
    
    emit voicesChanged();
    emit voicesUpdated();
}

void TTSManager::updateSupportedLanguages()
{
    if (!m_tts) return;
    
    m_supportedLanguages.clear();
    QList<QLocale> locales = m_tts->availableLocales();
    
    for (const QLocale &locale : locales) {
        QString language = locale.name().split('_').first();
        if (!m_supportedLanguages.contains(language)) {
            m_supportedLanguages.append(language);
        }
    }
    
    emit languagesChanged();
}

QString TTSManager::detectChineseDialect(const QString &text)
{
    Q_UNUSED(text)
    // Could be enhanced to detect Traditional vs Simplified
    return QStringLiteral("zh");
}

QString TTSManager::detectJapanese(const QString &text)
{
    Q_UNUSED(text)
    return QStringLiteral("ja");
}

QString TTSManager::detectKorean(const QString &text)
{
    Q_UNUSED(text)
    return QStringLiteral("ko");
}

QString TTSManager::detectArabic(const QString &text)
{
    Q_UNUSED(text)
    return QStringLiteral("ar");
}

QString TTSManager::detectRussian(const QString &text)
{
    Q_UNUSED(text)
    return QStringLiteral("ru");
}

bool TTSManager::isEnglish(const QString &text)
{
    return m_englishPattern.match(text).hasMatch();
}

QVoice TTSManager::findVoiceByName(const QString &voiceName)
{
    if (!m_tts) return QVoice();
    
    QList<QVoice> voices = m_tts->availableVoices();
    for (const QVoice &voice : voices) {
        if (voiceToString(voice) == voiceName) {
            return voice;
        }
    }
    return QVoice();
}

QVoice TTSManager::findBestVoiceForLanguage(const QString &language)
{
    if (!m_tts) return QVoice();
    
    QList<QLocale> locales = m_tts->availableLocales();
    QLocale targetLocale;
    
    // Find locale for language
    for (const QLocale &locale : locales) {
        if (locale.name().startsWith(language)) {
            targetLocale = locale;
            break;
        }
    }
    
    if (targetLocale == QLocale::c()) {
        return QVoice(); // No suitable locale found
    }
    
    // Find voice for locale
    m_tts->setLocale(targetLocale);
    QList<QVoice> voices = m_tts->availableVoices();
    
    if (!voices.isEmpty()) {
        return voices.first();
    }
    
    return QVoice();
}

QString TTSManager::voiceToString(const QVoice &voice) const
{
    return QString("%1 (%2, %3)")
        .arg(voice.name())
        .arg(QVoice::genderName(voice.gender()))
        .arg(QVoice::ageName(voice.age()));
}

void TTSManager::applyStoredSettings()
{
    if (!m_tts) return;
    
    // Apply engine
    if (!m_currentEngine.isEmpty() && m_currentEngine != currentEngine()) {
        setCurrentEngine(m_currentEngine);
    }
    
    // Apply voice
    if (!m_currentVoice.isEmpty()) {
        setCurrentVoice(m_currentVoice);
    }
    
    // Apply language
    if (!m_currentLanguage.isEmpty()) {
        setCurrentLanguage(m_currentLanguage);
    }
    
    // Apply speech parameters
    setRate(m_rate);
    setPitch(m_pitch);
    setVolume(m_volume);
}

// Multilingual testing functions
void TTSManager::testMultilingualSpeech()
{
    if (!isAvailable()) {
        emit speechError("TTS not available for multilingual test");
        return;
    }
    
    // Test phrases in different languages
    QStringList testPhrases = {
        "Hello, this is an English test",           // English
        "Hola, esta es una prueba en español",      // Spanish  
        "Bonjour, ceci est un test en français",    // French
        "Hallo, dies ist ein Test auf Deutsch",     // German
        "Ciao, questo è un test in italiano",       // Italian
        "こんにちは、これは日本語のテストです",              // Japanese
        "你好，这是中文测试",                          // Chinese (Simplified)
        "안녕하세요, 이것은 한국어 테스트입니다",            // Korean
        "Привет, это тест на русском языке",        // Russian
        "مرحبا، هذا اختبار باللغة العربية"           // Arabic
    };
    
    QStringList languages = {
        "en", "es", "fr", "de", "it", "ja", "zh", "ko", "ru", "ar"
    };
    
    // Clear queue and add all test phrases
    clearQueue();
    
    for (int i = 0; i < testPhrases.size() && i < languages.size(); ++i) {
        addToQueueWithLanguage(testPhrases[i], languages[i]);
    }
    
    qDebug() << "TTS: Queued" << testPhrases.size() << "multilingual test phrases";
}

void TTSManager::testLanguage(const QString &language, const QString &text)
{
    if (!isAvailable()) {
        emit speechError("TTS not available for language test");
        return;
    }
    
    QString testText = text;
    if (testText.isEmpty()) {
        // Default test phrases for different languages
        if (language == "en") testText = "Hello, this is a test in English";
        else if (language == "es") testText = "Hola, esta es una prueba en español";
        else if (language == "fr") testText = "Bonjour, ceci est un test en français";
        else if (language == "de") testText = "Hallo, dies ist ein Test auf Deutsch";
        else if (language == "it") testText = "Ciao, questo è un test in italiano";
        else if (language == "ja") testText = "こんにちは、これは日本語のテストです";
        else if (language == "zh") testText = "你好，这是中文测试";
        else if (language == "ko") testText = "안녕하세요, 이것은 한국어 테스트입니다";
        else if (language == "ru") testText = "Привет, это тест на русском языке";
        else if (language == "ar") testText = "مرحبا، هذا اختبار باللغة العربية";
        else testText = "Hello, this is a test in " + language;
    }
    
    speakWithLanguage(testText, language);
    qDebug() << "TTS: Testing language" << language << "with text:" << testText;
}

QString TTSManager::getPlatformInfo()
{
    QString info;
    info += "Platform: ";
    
#ifdef Q_OS_WINDOWS
    info += "Windows";
#elif defined(Q_OS_LINUX)
    info += "Linux";
#elif defined(Q_OS_MACOS)
    info += "macOS";
#elif defined(Q_OS_IOS)
    info += "iOS";
#elif defined(Q_OS_ANDROID)
    info += "Android";
#else
    info += "Unknown";
#endif
    
    info += "\nTTS Engine: " + currentEngine();
    info += "\nAvailable Engines: " + availableEngines().join(", ");
    info += "\nSupported Languages: " + supportedLanguages().join(", ");
    info += "\nTotal Voices: " + QString::number(availableVoiceNames().size());
    
    return info;
}

QStringList TTSManager::getAvailableLocaleNames()
{
    if (!m_tts) return QStringList();
    
    QStringList localeNames;
    QList<QLocale> locales = m_tts->availableLocales();
    
    for (const QLocale &locale : locales) {
        localeNames.append(QString("%1 (%2)")
                          .arg(locale.nativeLanguageName())
                          .arg(locale.name()));
    }
    
    return localeNames;
}

// Debug functions
QString TTSManager::debugTTSStatus()
{
    QString status;
    status += "=== TTS DEBUG STATUS ===\n";
    
    // Basic info
    status += QString("Initialized: %1\n").arg(m_isInitialized ? "Yes" : "No");
    status += QString("TTS Object: %1\n").arg(m_tts ? "Valid" : "NULL");
    
    if (!m_tts) {
        status += "ERROR: No TTS object - initialization failed!\n";
        return status;
    }
    
    status += QString("Current Engine: %1\n").arg(m_tts->engine());
    status += QString("Current State: %1\n").arg(m_tts->state() == QTextToSpeech::Ready ? "Ready" :
                                                  m_tts->state() == QTextToSpeech::Speaking ? "Speaking" :
                                                  m_tts->state() == QTextToSpeech::Paused ? "Paused" :
                                                  m_tts->state() == QTextToSpeech::Error ? "Error" : "Unknown");
    status += QString("Available: %1\n").arg(isAvailable() ? "Yes" : "No");
    
    // Engines
    QStringList engines = QTextToSpeech::availableEngines();
    status += QString("Available Engines (%1): %2\n").arg(engines.size()).arg(engines.join(", "));
    
    // Locales
    QList<QLocale> locales = m_tts->availableLocales();
    status += QString("Available Locales: %1\n").arg(locales.size());
    
    // Voices
    status += QString("Total Voices Found: %1\n").arg(m_availableVoiceNames.size());
    status += QString("Current Voice: %1\n").arg(m_currentVoice);
    status += QString("Current Language: %1\n").arg(m_currentLanguage);
    
    // Show first few voices
    status += "\nFirst few voices:\n";
    for (int i = 0; i < qMin(5, m_availableVoiceNames.size()); ++i) {
        status += QString("  %1: %2\n").arg(i + 1).arg(m_availableVoiceNames[i]);
    }
    
    if (m_availableVoiceNames.size() > 5) {
        status += QString("  ... and %1 more\n").arg(m_availableVoiceNames.size() - 5);
    }
    
    return status;
}

void TTSManager::debugLogAllInfo()
{
    qDebug() << "TTS: === COMPLETE DEBUG LOG ===";
    qDebug() << debugTTSStatus();
    
    if (m_tts) {
        // Test basic functionality
        qDebug() << "TTS: Testing basic say() function...";
        m_tts->say("Test speech");
        
        // List all engines and try each one
        QStringList engines = QTextToSpeech::availableEngines();
        for (const QString &engine : engines) {
            qDebug() << "TTS: Testing engine:" << engine;
            QTextToSpeech *testTts = new QTextToSpeech(engine, this);
            qDebug() << "TTS: Engine" << engine << "state:" << testTts->state();
            qDebug() << "TTS: Engine" << engine << "locales:" << testTts->availableLocales().size();
            qDebug() << "TTS: Engine" << engine << "voices:" << testTts->availableVoices().size();
            delete testTts;
        }
    }
}

void TTSManager::forceRefreshAll()
{
    qDebug() << "TTS: Force refreshing all TTS data...";
    
    if (m_tts) {
        // Reinitialize completely
        delete m_tts;
        m_tts = nullptr;
        m_isInitialized = false;
    }
    
    // Clear all data
    m_availableVoiceNames.clear();
    m_supportedLanguages.clear();
    m_currentVoice.clear();
    m_currentLanguage = "en";
    
    // Reinitialize
    initializeTTS();
}

void TTSManager::getCurrentVoices()
{
    qDebug() << "TTS: getCurrentVoices() called - refreshing voice list";
    updateAvailableVoices();
    emit voicesUpdated();
}

void TTSManager::setVoice(const QVariant &voice)
{
    if (voice.canConvert<QVariantMap>()) {
        QVariantMap voiceMap = voice.toMap();
        QString voiceName = voiceMap["name"].toString();
        setCurrentVoice(voiceName);
    } else {
        QString voiceName = voice.toString();
        setCurrentVoice(voiceName);
    }
}

void TTSManager::testTTS()
{
    if (!isAvailable()) {
        emit speechError("TTS not available for test");
        return;
    }
    
    // Use current language for test or auto-detect
    QString testText = "Hello, this is a test of the text to speech system.";
    QString currentLang = m_currentLanguage;
    
    if (currentLang.isEmpty() || m_autoDetectLanguage) {
        currentLang = detectLanguage(testText);
    }
    
    // Use multilingual test if no specific language
    if (currentLang.isEmpty()) {
        testMultilingualSpeech();
    } else {
        testLanguage(currentLang, testText);
    }
} 