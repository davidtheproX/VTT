#ifndef TTSMANAGER_H
#define TTSMANAGER_H

#include <QObject>
#include <QTextToSpeech>
#include <QVoice>
#include <QString>
#include <QStringList>
#include <QSettings>
#include <QTimer>
#include <QQueue>
#include <QRegularExpression>
#include <QLocale>
#include <QVariantList>

struct SpeechRequest {
    QString text;
    QString language;
    double rate;
    double pitch;
    double volume;
};

class TTSManager : public QObject
{
    Q_OBJECT

    // Basic TTS properties
    Q_PROPERTY(bool available READ isAvailable NOTIFY availabilityChanged)
    Q_PROPERTY(bool isEnabled READ isEnabled WRITE setIsEnabled NOTIFY enabledChanged)
    Q_PROPERTY(QString currentEngine READ currentEngine WRITE setCurrentEngine NOTIFY engineChanged)
    Q_PROPERTY(QStringList availableEngines READ availableEngines NOTIFY enginesChanged)
    Q_PROPERTY(QString currentVoice READ currentVoice WRITE setCurrentVoice NOTIFY voiceChanged)
    Q_PROPERTY(QString currentVoiceName READ currentVoiceName NOTIFY voiceChanged)
    Q_PROPERTY(QStringList availableVoiceNames READ availableVoiceNames NOTIFY voicesChanged)
    Q_PROPERTY(QStringList voiceNames READ availableVoiceNames NOTIFY voicesChanged)
    Q_PROPERTY(QVariantList availableVoices READ getAvailableVoicesAsVariant NOTIFY voicesChanged)
    
    // Speech parameters
    Q_PROPERTY(double rate READ rate WRITE setRate NOTIFY rateChanged)
    Q_PROPERTY(double pitch READ pitch WRITE setPitch NOTIFY pitchChanged)
    Q_PROPERTY(double volume READ volume WRITE setVolume NOTIFY volumeChanged)
    
    // Language and detection
    Q_PROPERTY(QString currentLanguage READ currentLanguage WRITE setCurrentLanguage NOTIFY languageChanged)
    Q_PROPERTY(QStringList supportedLanguages READ supportedLanguages NOTIFY languagesChanged)
    Q_PROPERTY(bool autoDetectLanguage READ autoDetectLanguage WRITE setAutoDetectLanguage NOTIFY autoDetectChanged)
    
    // State
    Q_PROPERTY(bool isSpeaking READ isSpeaking NOTIFY speakingChanged)
    Q_PROPERTY(bool paused READ isPaused NOTIFY pausedChanged)
    Q_PROPERTY(int queueSize READ queueSize NOTIFY queueSizeChanged)

public:
    explicit TTSManager(QObject *parent = nullptr);
    ~TTSManager();

    // Basic properties
    bool isAvailable() const;
    bool isEnabled() const;
    QString currentEngine() const;
    QStringList availableEngines() const;
    QString currentVoice() const;
    QString currentVoiceName() const;
    QStringList availableVoiceNames() const;
    QVariantList getAvailableVoicesAsVariant() const;
    
    // Speech parameters
    double rate() const;
    double pitch() const;
    double volume() const;
    
    // Language
    QString currentLanguage() const;
    QStringList supportedLanguages() const;
    bool autoDetectLanguage() const;
    
    // State
    bool isSpeaking() const;
    bool isPaused() const;
    int queueSize() const;

public slots:
    // Engine and voice management
    void setIsEnabled(bool enabled);
    void setCurrentEngine(const QString &engine);
    void setCurrentVoice(const QString &voiceName);
    void setVoice(const QVariant &voice);
    void setVoiceByIndex(int index);
    void refreshVoices();
    Q_INVOKABLE void getCurrentVoices();
    
    // Speech parameters
    void setRate(double rate);
    void setPitch(double pitch);
    void setVolume(double volume);
    
    // Language management
    void setCurrentLanguage(const QString &language);
    void setAutoDetectLanguage(bool autoDetect);
    QString detectLanguage(const QString &text);
    
    // Main TTS functions - Detect -> Query -> Set -> Speak pattern
    void speak(const QString &text);
    void speakWithLanguage(const QString &text, const QString &language);
    void speakWithSettings(const QString &text, const QString &language, double rate, double pitch, double volume);
    
    // Queue management
    void addToQueue(const QString &text);
    void addToQueueWithLanguage(const QString &text, const QString &language);
    void clearQueue();
    void skipCurrent();
    
    // Playback control
    void pause();
    void resume();
    void stop();
    
    // Settings persistence
    void saveSettings();
    void loadSettings();
    void resetToDefaults();
    
    // Test functions
    Q_INVOKABLE void testTTS();
    Q_INVOKABLE void testMultilingualSpeech();
    Q_INVOKABLE void testLanguage(const QString &language, const QString &text = QString());
    Q_INVOKABLE QString getPlatformInfo();
    Q_INVOKABLE QStringList getAvailableLocaleNames();
    
    // Debugging
    Q_INVOKABLE QString debugTTSStatus();
    Q_INVOKABLE void debugLogAllInfo();
    Q_INVOKABLE void forceRefreshAll();

signals:
    // Basic property signals
    void availabilityChanged(bool available);
    void enabledChanged(bool enabled);
    void engineChanged(const QString &engine);
    void enginesChanged();
    void voiceChanged(const QString &voice);
    void voicesChanged();
    void voicesUpdated();
    
    // Parameter signals
    void rateChanged(double rate);
    void pitchChanged(double pitch);
    void volumeChanged(double volume);
    
    // Language signals
    void languageChanged(const QString &language);
    void languagesChanged();
    void autoDetectChanged(bool autoDetect);
    
    // State signals
    void speakingChanged(bool speaking);
    void pausedChanged(bool paused);
    void queueSizeChanged(int size);
    
    // Progress signals
    void speechStarted();
    void speechFinished();
    void speechError(const QString &error);
    void languageDetected(const QString &detectedLanguage);

private slots:
    void onStateChanged(QTextToSpeech::State state);
    void onErrorOccurred(QTextToSpeech::ErrorReason reason, const QString &errorString);
    void processNextInQueue();

private:
    // Core TTS functionality
    void initializeTTS();
    void updateAvailableVoices();
    void updateSupportedLanguages();
    
    // Language detection helpers
    QString detectChineseDialect(const QString &text);
    QString detectJapanese(const QString &text);
    QString detectKorean(const QString &text);
    QString detectArabic(const QString &text);
    QString detectRussian(const QString &text);
    bool isEnglish(const QString &text);
    
    // Voice management helpers
    QVoice findVoiceByName(const QString &voiceName);
    QVoice findBestVoiceForLanguage(const QString &language);
    QString voiceToString(const QVoice &voice) const;
    
    // Settings helpers
    void applyStoredSettings();
    
    // Member variables
    QTextToSpeech *m_tts;
    QSettings *m_settings;
    QTimer *m_queueTimer;
    QQueue<SpeechRequest> m_speechQueue;
    
    // Current state
    QString m_currentEngine;
    QString m_currentVoice;
    QString m_currentLanguage;
    QStringList m_availableVoiceNames;
    QStringList m_supportedLanguages;
    
    // Speech parameters
    double m_rate;
    double m_pitch;
    double m_volume;
    
    // Settings
    bool m_autoDetectLanguage;
    bool m_isInitialized;
    
    // Language detection patterns
    QRegularExpression m_chinesePattern;
    QRegularExpression m_japanesePattern;
    QRegularExpression m_koreanPattern;
    QRegularExpression m_arabicPattern;
    QRegularExpression m_russianPattern;
    QRegularExpression m_englishPattern;
};

#endif // TTSMANAGER_H 