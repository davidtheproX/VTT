#include "TTSManager.h"
#include "PlatformDetection.h"
#include <QDebug>
#include <QLocale>
#include <QRegularExpression>
#include <QThread>
#include <QTimer>
#include <QSet>
#include <algorithm>
#include <QRandomGenerator>
#include <QTextStream>

// Platform-specific includes based on detected platform
#ifdef PLATFORM_WINDOWS
    #include <QOperatingSystemVersion>
#endif

#ifdef PLATFORM_ANDROID
    #include <QJniObject>
#endif

// Voice presets
const TTSManager::VoicePreset TTSManager::JARVIS_PRESET = {
    "Jarvis",
    0.8,    // Slightly slower rate
    0.3,    // Lower pitch for that deep AI voice
    0.9,    // High volume
    "Microsoft David",  // Preferred voice (deep male voice)
    "Male"
};

const TTSManager::VoicePreset TTSManager::NATURAL_PRESET = {
    "Natural",
    1.0,    // Normal rate
    0.5,    // Normal pitch
    0.8,    // Normal volume
    "Microsoft Zira",   // Natural female voice
    "Female"
};

const TTSManager::VoicePreset TTSManager::ROBOT_PRESET = {
    "Robot",
    0.6,    // Slower rate
    0.1,    // Very low pitch
    1.0,    // Maximum volume
    "Microsoft Sam",    // Robotic voice
    "Male"
};

const TTSManager::VoicePreset TTSManager::CHINESE_PRESET = {
    "Chinese",
    0.9,    // Slightly slower for better pronunciation
    0.5,    // Normal pitch
    0.8,    // Normal volume
    "Microsoft Huihui",  // Chinese voice (if available)
    "Female"
};

TTSManager::TTSManager(QObject *parent)
    : QObject(parent)
    , m_tts(nullptr)
    , m_isEnabled(false)
    , m_currentVoiceName("")
{
    initialize();
}

TTSManager::~TTSManager()
{
    if (m_tts) {
        m_tts->stop();
        delete m_tts;
    }
}

void TTSManager::initialize()
{
    qDebug() << "Initializing TTS Manager on platform:" << PLATFORM_NAME;
    
    try {
        // Platform-specific TTS initialization and voice engine selection
#ifdef Q_OS_WIN
        qDebug() << "Using Windows TTS (SAPI) - optimized for Windows voices";
        m_tts = new QTextToSpeech(this);
#elif defined(Q_OS_MACOS) || defined(Q_OS_IOS)
        qDebug() << "Using macOS/iOS TTS (AVSpeechSynthesizer) - optimized for Apple voices";
        m_tts = new QTextToSpeech(this);
#elif defined(Q_OS_ANDROID)
        qDebug() << "Using Android TTS (TextToSpeech API) - optimized for Google voices";
        m_tts = new QTextToSpeech(this);
        
        // Android TTS debugging
        QTimer::singleShot(1000, this, [this]() {
            if (m_tts) {
                qDebug() << "Android TTS delayed check:";
                qDebug() << "  TTS State:" << m_tts->state();
                qDebug() << "  Available Locales:" << m_tts->availableLocales().size();
                qDebug() << "  Available Voices:" << m_tts->availableVoices().size();
                
                if (m_tts->availableVoices().isEmpty()) {
                    qWarning() << "No Android TTS voices found!";
                    qWarning() << "Please install Google TTS from Play Store and ensure language packs are downloaded";
                    qWarning() << "Go to Settings > Language & Input > Text-to-speech output > Google Text-to-speech Engine";
                    emit error("No TTS voices available. Please install Google TTS and language packs from Android Settings.");
                }
            }
        });
#elif defined(Q_OS_LINUX)
        qDebug() << "Using Linux TTS (speech-dispatcher/espeak) - cross-platform voices";
        m_tts = new QTextToSpeech(this);
#else
        qDebug() << "Using default TTS engine on unknown platform";
        m_tts = new QTextToSpeech(this);
#endif
        
        connect(m_tts, &QTextToSpeech::stateChanged,
                this, &TTSManager::onStateChanged);
        
        connect(m_tts, &QTextToSpeech::errorOccurred,
                this, &TTSManager::onErrorOccurred);
        
        loadAvailableVoices();
        
        // Set default to Jarvis preset
        applyJarvisVoicePreset();
        
        qDebug() << "TTS Manager initialized successfully on" << PLATFORM_NAME;
        qDebug() << "Available voices:" << m_availableVoices.size();
        
    } catch (const std::exception &e) {
        qCritical() << "Failed to initialize TTS on" << PLATFORM_NAME << ":" << e.what();
        emit error("Failed to initialize text-to-speech: " + QString(e.what()));
    }
}



void TTSManager::loadAvailableVoices()
{
    if (!m_tts) return;
    
    qDebug() << "Loading available voices...";
    
    // Clear previous voices
    m_voices.clear();
    m_availableVoices.clear();
    
    // Get all available locales and their voices
    QList<QLocale> locales = m_tts->availableLocales();
    qDebug() << "Available locales:" << locales.size();
    
    // Collect voices from all locales to ensure we get Chinese voices
    QSet<QString> uniqueVoiceNames; // Prevent duplicates
    
    for (const QLocale &locale : locales) {
        qDebug() << QString("Checking locale: %1 (%2)").arg(locale.name(), locale.nativeLanguageName());
            
        // Temporarily set this locale to get its voices
        QLocale originalLocale = m_tts->locale();
        m_tts->setLocale(locale);
        
            QList<QVoice> localeVoices = m_tts->availableVoices();
        qDebug() << QString("  Found %1 voices for locale %2").arg(localeVoices.size()).arg(locale.name());
        
            for (const QVoice &voice : localeVoices) {
            QString voiceKey = voice.name() + "_" + voice.locale().name();
            if (!uniqueVoiceNames.contains(voiceKey)) {
                uniqueVoiceNames.insert(voiceKey);
                m_voices.append(voice);
                
                // Special logging for Chinese voices
                if (locale.language() == QLocale::Chinese || 
                    voice.name().contains("Chinese", Qt::CaseInsensitive) ||
                    voice.name().contains("Huihui", Qt::CaseInsensitive) ||
                    voice.name().contains("中文", Qt::CaseInsensitive)) {
                    qDebug() << QString("  ** CHINESE VOICE DETECTED: %1 (Locale: %2)").arg(voice.name(), voice.locale().name());
                }
            }
        }
        
        // Restore original locale
        m_tts->setLocale(originalLocale);
    }
    
    // Also get voices from current locale to ensure we don't miss any
    QList<QVoice> defaultVoices = m_tts->availableVoices();
    for (const QVoice &voice : defaultVoices) {
        QString voiceKey = voice.name() + "_" + voice.locale().name();
        if (!uniqueVoiceNames.contains(voiceKey)) {
            uniqueVoiceNames.insert(voiceKey);
            m_voices.append(voice);
        }
    }
    
    qDebug() << QString("Total unique voices found: %1").arg(m_voices.size());
    
    // Create display names for all voices
    for (const QVoice &voice : m_voices) {
        QString displayName = getVoiceDisplayName(voice);
        m_availableVoices.append(displayName);
        
        // Enhanced Chinese voice detection and logging
        QLocale voiceLocale = voice.locale();
        bool isChineseLocale = voiceLocale.language() == QLocale::Chinese;
        bool isChineseName = voice.name().contains("Chinese", Qt::CaseInsensitive) ||
                            voice.name().contains("Mandarin", Qt::CaseInsensitive) ||
                            voice.name().contains("Huihui", Qt::CaseInsensitive) ||
                            voice.name().contains("Yaoyao", Qt::CaseInsensitive) ||
                            voice.name().contains("Kangkang", Qt::CaseInsensitive) ||
                            voice.name().contains("Tracy", Qt::CaseInsensitive) ||
                            voice.name().contains("Danny", Qt::CaseInsensitive) ||
                            voice.name().contains("中文", Qt::CaseInsensitive) ||
                            voice.name().contains("普通话", Qt::CaseInsensitive);
        bool isChinese = isChineseLocale || isChineseName;
        
        if (isChinese) {
            qDebug() << QString("✓ CHINESE VOICE ADDED: %1").arg(displayName);
            qDebug() << QString("    Raw name: %1").arg(voice.name());
        qDebug() << QString("    Locale: %1 (%2)").arg(voiceLocale.name(), voiceLocale.nativeLanguageName());
        qDebug() << QString("    Gender: %1, Age: %2").arg(
            voice.gender() == QVoice::Male ? "Male" : 
            voice.gender() == QVoice::Female ? "Female" : "Unknown").arg(voice.age());
        }
    }
    
    qDebug() << QString("Voice loading complete. %1 voices available in UI dropdown.").arg(m_availableVoices.size());
    emit availableVoicesChanged();
}

void TTSManager::refreshVoices()
{
    qDebug() << "Manual voice refresh requested";
    loadAvailableVoices();
    
    // Try to find and highlight Chinese voices for user
    int chineseCount = 0;
    for (const QString &voiceName : m_availableVoices) {
        if (voiceName.contains("Chinese", Qt::CaseInsensitive) ||
            voiceName.contains("Huihui", Qt::CaseInsensitive) ||
            voiceName.contains("中文", Qt::CaseInsensitive) ||
            voiceName.contains("普通话", Qt::CaseInsensitive)) {
            chineseCount++;
        }
    }
    
    qDebug() << QString("Voice refresh complete. Found %1 Chinese voices out of %2 total voices.")
                .arg(chineseCount).arg(m_availableVoices.size());
    
    if (chineseCount > 0) {
        qDebug() << "Chinese voices are now available in the voice selection dropdown!";
    } else {
        qDebug() << "No Chinese voices detected. You may need to install Chinese language pack.";
    }
}

QString TTSManager::getVoiceDisplayName(const QVoice &voice) const
{
    QString name = voice.name();
    
    // Add gender and age info
    QString genderStr = voice.gender() == QVoice::Male ? "Male" : 
                       voice.gender() == QVoice::Female ? "Female" : "Unknown";
    
    QString ageStr;
    switch (voice.age()) {
        case QVoice::Child: ageStr = "Child"; break;
        case QVoice::Teenager: ageStr = "Teen"; break;
        case QVoice::Adult: ageStr = "Adult"; break;
        case QVoice::Senior: ageStr = "Senior"; break;
        default: ageStr = "Adult"; break;
    }
    
    // Add language/locale info for better identification
    QLocale locale = voice.locale();
    QString languageStr = locale.nativeLanguageName();
    if (languageStr.isEmpty()) {
        languageStr = locale.name();
    }
    
    return QString("%1 (%2, %3, %4)").arg(name, genderStr, ageStr, languageStr);
}

bool TTSManager::isSpeaking() const
{
    return m_tts && m_tts->state() == QTextToSpeech::Speaking;
}

QTextToSpeech::State TTSManager::state() const
{
    return m_tts ? m_tts->state() : QTextToSpeech::Error;
}

void TTSManager::setIsEnabled(bool enabled)
{
    if (m_isEnabled != enabled) {
        m_isEnabled = enabled;
        
        if (!enabled && isSpeaking()) {
            stop();
        }
        
        emit enabledChanged();
        qDebug() << "TTS enabled:" << enabled;
    }
}

void TTSManager::setCurrentVoice(const QString &voiceName)
{
    if (m_currentVoiceName == voiceName) return;
    
    QVoice voice = findVoiceByName(voiceName);
    if (voice.name().isEmpty()) {
        qWarning() << "Voice not found:" << voiceName;
        return;
    }
    
    if (m_tts) {
        m_tts->setVoice(voice);
        m_currentVoiceName = voiceName;
        emit currentVoiceChanged();
        qDebug() << "Voice changed to:" << voiceName;
    }
}

QVoice TTSManager::findVoiceByName(const QString &name) const
{
    for (const QVoice &voice : m_voices) {
        if (getVoiceDisplayName(voice) == name || voice.name() == name) {
            return voice;
        }
    }
    return QVoice();
}

double TTSManager::rate() const
{
    return m_tts ? m_tts->rate() : 0.0;
}

void TTSManager::setRate(double rate)
{
    if (m_tts && m_tts->rate() != rate) {
        m_tts->setRate(rate);
        emit rateChanged();
    }
}

double TTSManager::pitch() const
{
    return m_tts ? m_tts->pitch() : 0.0;
}

void TTSManager::setPitch(double pitch)
{
    if (m_tts && m_tts->pitch() != pitch) {
        m_tts->setPitch(pitch);
        emit pitchChanged();
    }
}

double TTSManager::volume() const
{
    return m_tts ? m_tts->volume() : 0.0;
}

void TTSManager::setVolume(double volume)
{
    if (m_tts && m_tts->volume() != volume) {
        m_tts->setVolume(volume);
        emit volumeChanged();
    }
}

void TTSManager::speak(const QString &text)
{
    if (!m_isEnabled || !m_tts || text.trimmed().isEmpty()) {
        return;
    }
    
    qDebug() << "Speaking:" << text.left(50) + (text.length() > 50 ? "..." : "");
    
    try {
        // Stop any current speech to prevent conflicts
        if (m_tts->state() == QTextToSpeech::Speaking) {
            qDebug() << "Stopping current speech before starting new one";
            m_tts->stop();
            // Small delay to ensure previous speech stops
            QThread::msleep(100);
        }
    
    // Check if text contains Chinese characters and auto-switch to Chinese voice
    if (containsChinese(text)) {
        qDebug() << "Detected Chinese text, switching to Chinese voice";
            if (!findChineseVoice()) {
                qWarning() << "Failed to find Chinese voice, using current voice";
            }
    }
    
    // Clean up text for better speech
    QString cleanText = text;
    cleanText.replace("*", ""); // Remove markdown emphasis
    cleanText.replace("**", ""); // Remove markdown bold
    cleanText.replace("_", ""); // Remove markdown italic
    cleanText.replace("`", ""); // Remove code formatting
    cleanText.replace("```", ""); // Remove code blocks
    cleanText.replace("#", ""); // Remove markdown headers
        cleanText.replace(QRegularExpression("\\[.*?\\]"), ""); // Remove markdown links
        cleanText.replace(QRegularExpression("\\n+"), " "); // Replace newlines with spaces
        cleanText = cleanText.trimmed();
        
        if (cleanText.isEmpty()) {
            qWarning() << "Clean text is empty, skipping TTS";
            return;
        }
        
        // Ensure we're in a good state before speaking
        if (m_tts->state() == QTextToSpeech::Error) {
            qWarning() << "TTS is in error state, attempting to recover";
            // Try to reinitialize
            m_tts->stop();
            QThread::msleep(200);
        }
        
        qDebug() << "Starting TTS with cleaned text:" << cleanText.left(100);
    m_tts->say(cleanText);
        
    } catch (const std::exception &e) {
        qCritical() << "Exception in TTS speak:" << e.what();
        emit error("TTS Error: " + QString(e.what()));
    } catch (...) {
        qCritical() << "Unknown exception in TTS speak";
        emit error("Unknown TTS error occurred");
    }
}

void TTSManager::stop()
{
    if (m_tts) {
        m_tts->stop();
    }
}

void TTSManager::pause()
{
    if (m_tts && m_tts->state() == QTextToSpeech::Speaking) {
        m_tts->pause();
    }
}

void TTSManager::resume()
{
    if (m_tts && m_tts->state() == QTextToSpeech::Paused) {
        m_tts->resume();
    }
}

void TTSManager::applyJarvisVoicePreset()
{
    qDebug() << "Applying Jarvis voice preset";
    
    setRate(JARVIS_PRESET.rate);
    setPitch(JARVIS_PRESET.pitch);
    setVolume(JARVIS_PRESET.volume);
    
    findBestVoiceForPreset(JARVIS_PRESET.preferredVoiceName, JARVIS_PRESET.preferredGender);
}

void TTSManager::applyNaturalVoicePreset()
{
    qDebug() << "Applying Natural voice preset";
    
    setRate(NATURAL_PRESET.rate);
    setPitch(NATURAL_PRESET.pitch);
    setVolume(NATURAL_PRESET.volume);
    
    findBestVoiceForPreset(NATURAL_PRESET.preferredVoiceName, NATURAL_PRESET.preferredGender);
}

void TTSManager::applyRobotVoicePreset()
{
    qDebug() << "Applying Robot voice preset";
    
    setRate(ROBOT_PRESET.rate);
    setPitch(ROBOT_PRESET.pitch);
    setVolume(ROBOT_PRESET.volume);
    
    findBestVoiceForPreset(ROBOT_PRESET.preferredVoiceName, ROBOT_PRESET.preferredGender);
}

void TTSManager::applyChineseVoicePreset()
{
    qDebug() << "Applying Chinese voice preset";
    
    setRate(CHINESE_PRESET.rate);
    setPitch(CHINESE_PRESET.pitch);
    setVolume(CHINESE_PRESET.volume);
    
    // Try to find Chinese voices by checking all locales
    if (findChineseVoice()) {
        qDebug() << "Chinese voice preset applied successfully";
    } else {
        qWarning() << "No Chinese voice found, keeping current voice";
        // Don't override with findBestVoiceForPreset as it may select non-Chinese voice
    }
}

bool TTSManager::findChineseVoice()
{
    if (!m_tts) return false;
    
    qDebug() << "Searching for Chinese voices on" << PLATFORM_NAME;
    
    // Platform-specific Chinese voice names to search for
    QStringList platformChineseVoices;
    
#ifdef Q_OS_WIN
    // Windows SAPI Chinese voices
    platformChineseVoices << "Microsoft Huihui Desktop"
                         << "Microsoft Yaoyao Desktop" 
                         << "Microsoft Kangkang Desktop"
                         << "Microsoft Tracy Desktop"
                         << "Microsoft Danny Desktop"
                         << "Microsoft Zhiwei"
                         << "Huihui" << "Yaoyao" << "Kangkang"
                         << "Chinese" << "Mandarin";
#elif defined(Q_OS_MACOS) || defined(Q_OS_IOS)
    // macOS/iOS Chinese voices
    platformChineseVoices << "Ting-Ting" << "Sin-ji" << "Mei-Jia"
                         << "Yu-shu" << "Yuna" << "Li-mu"
                         << "Chinese" << "Mandarin" << "Cantonese";
#elif defined(Q_OS_ANDROID)
    // Android Chinese voices
    platformChineseVoices << "Chinese (China)" << "Chinese (Taiwan)"
                         << "Chinese (Hong Kong)" << "Mandarin"
                         << "zh-CN" << "zh-TW" << "zh-HK";
#elif defined(Q_OS_LINUX)
    // Linux espeak/festival Chinese voices
    platformChineseVoices << "mandarin" << "cantonese" << "chinese"
                         << "zh" << "zh-cn" << "zh-tw";
#endif

    // Add common Chinese voice names for all platforms
    platformChineseVoices << "中文" << "普通话" << "粤语" << "国语"
                         << "华语" << "Chinese" << "Mandarin" << "Cantonese";
    
    // First try to find any voice with Chinese locale
    QList<QLocale> locales = m_tts->availableLocales();
    for (const QLocale &locale : locales) {
        if (locale.language() == QLocale::Chinese) {
            qDebug() << "Found Chinese locale:" << locale.name() << "(" << locale.nativeLanguageName() << ")";
            m_tts->setLocale(locale);
            
            // Now get voices for this locale
            QList<QVoice> chineseVoices = m_tts->availableVoices();
            if (!chineseVoices.isEmpty()) {
                QVoice bestChineseVoice = chineseVoices.first();
                
                // Prefer voices that match platform-specific names
                for (const QVoice &voice : chineseVoices) {
                    for (const QString &preferredName : platformChineseVoices) {
                        if (voice.name().contains(preferredName, Qt::CaseInsensitive)) {
                            bestChineseVoice = voice;
                            qDebug() << "Found platform-specific Chinese voice:" << voice.name();
                            goto voice_found; // break out of nested loops
                        }
                    }
                }
                
                // If no platform-specific voice found, prefer female voice
                for (const QVoice &voice : chineseVoices) {
                    if (voice.gender() == QVoice::Female) {
                        bestChineseVoice = voice;
                        qDebug() << "Found female Chinese voice:" << voice.name();
                        break;
                    }
                }
                
                voice_found:
                // Double-check we're setting the right voice
                if (!bestChineseVoice.name().isEmpty()) {
                m_tts->setVoice(bestChineseVoice);
                m_currentVoiceName = getVoiceDisplayName(bestChineseVoice);
                emit currentVoiceChanged();
                qDebug() << "Successfully set Chinese voice:" << m_currentVoiceName;
                    qDebug() << "Voice name:" << bestChineseVoice.name();
                    qDebug() << "Voice locale:" << bestChineseVoice.locale().name();
                    return true;
                } else {
                    qWarning() << "Best Chinese voice is empty, continuing search";
                }
            }
        }
    }
    
    // Fallback: search all voices by name for Chinese characteristics
    qDebug() << "No Chinese locale found, searching by voice names...";
    for (const QVoice &voice : m_voices) {
        for (const QString &chineseName : platformChineseVoices) {
            if (voice.name().contains(chineseName, Qt::CaseInsensitive)) {
                m_tts->setVoice(voice);
                m_currentVoiceName = getVoiceDisplayName(voice);
                emit currentVoiceChanged();
                qDebug() << "Found Chinese voice by name:" << m_currentVoiceName;
                return true;
            }
        }
    }
    
    qDebug() << "No Chinese voices found on" << PLATFORM_NAME;
    return false;
}

bool TTSManager::containsChinese(const QString &text)
{
    // Check if text contains Chinese characters (CJK Unified Ideographs)
    for (const QChar &ch : text) {
        ushort unicode = ch.unicode();
        // Chinese characters range: 0x4E00-0x9FFF (CJK Unified Ideographs)
        // Also check: 0x3400-0x4DBF (CJK Extension A)
        if ((unicode >= 0x4E00 && unicode <= 0x9FFF) ||
            (unicode >= 0x3400 && unicode <= 0x4DBF)) {
            return true;
        }
    }
    return false;
}

void TTSManager::findBestVoiceForPreset(const QString &preferredName, const QString &preferredGender)
{
    if (!m_tts) return;
    
    QVoice bestVoice;
    
    // Special handling for Chinese voices
    if (preferredName.contains("Chinese", Qt::CaseInsensitive) || 
        preferredName.contains("Huihui", Qt::CaseInsensitive)) {
        
        // First priority: Look for voices with Chinese locale
        for (const QVoice &voice : m_voices) {
            if (voice.locale().language() == QLocale::Chinese) {
                bestVoice = voice;
                qDebug() << "Found Chinese locale voice:" << voice.name();
                break;
            }
        }
        
        // Second priority: Look for Chinese voices by name
        if (bestVoice.name().isEmpty()) {
            QStringList chineseVoiceNames = {"Huihui", "Yaoyao", "Kangkang", "Chinese", "中文"};
            
            for (const QString &chineseName : chineseVoiceNames) {
                for (const QVoice &voice : m_voices) {
                    if (voice.name().contains(chineseName, Qt::CaseInsensitive)) {
                        bestVoice = voice;
                        qDebug() << "Found Chinese name voice:" << voice.name();
                        break;
                    }
                }
                if (!bestVoice.name().isEmpty()) break;
            }
        }
    }
    
    // First, try to find the exact preferred voice
    if (bestVoice.name().isEmpty()) {
        for (const QVoice &voice : m_voices) {
            if (voice.name().contains(preferredName, Qt::CaseInsensitive)) {
                bestVoice = voice;
                break;
            }
        }
    }
    
    // If not found, find by gender
    if (bestVoice.name().isEmpty()) {
        QVoice::Gender targetGender = preferredGender.toLower() == "male" ? QVoice::Male : QVoice::Female;
        
        for (const QVoice &voice : m_voices) {
            if (voice.gender() == targetGender) {
                bestVoice = voice;
                break;
            }
        }
    }
    
    // Fallback to first available voice
    if (bestVoice.name().isEmpty() && !m_voices.isEmpty()) {
        bestVoice = m_voices.first();
    }
    
    if (!bestVoice.name().isEmpty()) {
        m_tts->setVoice(bestVoice);
        m_currentVoiceName = getVoiceDisplayName(bestVoice);
        emit currentVoiceChanged();
        qDebug() << "Selected voice:" << m_currentVoiceName;
    }
}

void TTSManager::onStateChanged(QTextToSpeech::State state)
{
    emit stateChanged(state);
    emit speakingChanged();
    
    switch (state) {
        case QTextToSpeech::Ready:
            qDebug() << "TTS Ready";
            break;
        case QTextToSpeech::Speaking:
            qDebug() << "TTS Speaking";
            break;
        case QTextToSpeech::Paused:
            qDebug() << "TTS Paused";
            break;
        case QTextToSpeech::Error:
            qDebug() << "TTS Error";
            break;
    }
}

void TTSManager::onErrorOccurred(QTextToSpeech::ErrorReason reason, const QString &errorString)
{
    QString errorMsg = "TTS Error: " + errorString;
    
    // Add reason-specific context and recovery attempts
    switch (reason) {
        case QTextToSpeech::ErrorReason::Initialization:
            errorMsg += " (Initialization failed - attempting recovery)";
            qCritical() << "TTS initialization error, attempting to reinitialize...";
            // Attempt to recover by reinitializing
            QTimer::singleShot(1000, this, [this]() {
                try {
                    if (m_tts) {
                        m_tts->stop();
                        QThread::msleep(500);
                        qDebug() << "Attempting TTS recovery...";
                    }
                } catch (...) {
                    qCritical() << "Failed to recover TTS";
                }
            });
            break;
        case QTextToSpeech::ErrorReason::Configuration:
            errorMsg += " (Configuration error - check voice settings)";
            qWarning() << "TTS configuration error, may need to select different voice";
            break;
        case QTextToSpeech::ErrorReason::Input:
            errorMsg += " (Input error - invalid text)";
            qWarning() << "TTS input error, text may be invalid or too long";
            break;
        case QTextToSpeech::ErrorReason::Playback:
            errorMsg += " (Playback error - audio device issue)";
            qWarning() << "TTS playback error, check audio device availability";
            // Stop any ongoing speech and reset
            if (m_tts) {
                m_tts->stop();
            }
            break;
        default:
            errorMsg += " (Unknown error)";
            break;
    }
    
    qWarning() << "TTS Error occurred:" << errorMsg << "Reason:" << reason;
    
    // Don't emit too many errors to avoid spam
    static int errorCount = 0;
    errorCount++;
    if (errorCount <= 3) {
    emit error(errorMsg);
    } else if (errorCount == 4) {
        emit error("TTS experiencing multiple errors - check system audio");
    }
    
    // Reset error count after some time
    QTimer::singleShot(30000, []() { 
        static int* errorCountPtr = &errorCount;
        *errorCountPtr = 0; 
    });
} 