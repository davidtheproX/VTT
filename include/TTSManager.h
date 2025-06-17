#ifndef TTSMANAGER_H
#define TTSMANAGER_H

#include <QObject>
#include <QString>
#include <QTextToSpeech>
#include <QVoice>
#include <QLocale>
#include <QRegularExpression>
#include <QTimer>
#include <QQueue>
#include <QJsonObject>

class TTSManager : public QObject
{
    Q_OBJECT

    // Properties for QML binding
    Q_PROPERTY(bool isEnabled READ isEnabled WRITE setIsEnabled NOTIFY isEnabledChanged)
    Q_PROPERTY(bool isSpeaking READ isSpeaking NOTIFY isSpeakingChanged)
    Q_PROPERTY(QStringList voiceNames READ voiceNames NOTIFY voicesChanged)
    Q_PROPERTY(QList<QVoice> availableVoices READ availableVoices NOTIFY voicesChanged)
    Q_PROPERTY(QString currentVoiceName READ currentVoiceName NOTIFY currentVoiceChanged)
    Q_PROPERTY(double rate READ rate WRITE setRate NOTIFY rateChanged)
    Q_PROPERTY(double pitch READ pitch WRITE setPitch NOTIFY pitchChanged)
    Q_PROPERTY(double volume READ volume WRITE setVolume NOTIFY volumeChanged)
    Q_PROPERTY(QStringList availableLanguages READ availableLanguages NOTIFY languagesChanged)
    Q_PROPERTY(QString currentLanguage READ currentLanguage NOTIFY currentLanguageChanged)

public:
    explicit TTSManager(QObject *parent = nullptr);
    ~TTSManager();

    // Main speaking function - implements the "Detect -> Query -> Set -> Speak" pattern
    Q_INVOKABLE void speak(const QString &text);
    Q_INVOKABLE void stop();
    Q_INVOKABLE void pause();
    Q_INVOKABLE void resume();

    // Language detection functions
    Q_INVOKABLE QString detectLanguage(const QString &text);
    Q_INVOKABLE bool isLanguageSupported(const QString &languageCode);

    // Voice management
    Q_INVOKABLE void refreshVoices();
    Q_INVOKABLE void setVoiceByIndex(int index);
    Q_INVOKABLE void setVoiceByName(const QString &voiceName);
    Q_INVOKABLE void setVoice(const QVoice &voice);

    // Test functions
    Q_INVOKABLE void testTTS();
    Q_INVOKABLE void testLanguageDetection();

    // Settings management
    Q_INVOKABLE QJsonObject getSettings();
    Q_INVOKABLE void loadSettings(const QJsonObject &settings);

    // Property getters
    bool isEnabled() const;
    bool isSpeaking() const;
    QStringList voiceNames() const;
    QList<QVoice> availableVoices() const;
    QString currentVoiceName() const;
    double rate() const;
    double pitch() const;
    double volume() const;
    QStringList availableLanguages() const;
    QString currentLanguage() const;

public slots:
    // Property setters
    void setIsEnabled(bool enabled);
    void setRate(double rate);
    void setPitch(double pitch);
    void setVolume(double volume);

private slots:
    void handleStateChanged(QTextToSpeech::State state);
    void handleErrorOccurred(QTextToSpeech::ErrorReason reason);
    void processQueue();

signals:
    // Property change signals
    void isEnabledChanged();
    void isSpeakingChanged();
    void voicesChanged();
    void currentVoiceChanged();
    void rateChanged();
    void pitchChanged();
    void volumeChanged();
    void languagesChanged();
    void currentLanguageChanged();

    // Status signals
    void speechFinished();
    void speechError(const QString &error);
    void languageDetected(const QString &language, const QString &text);

private:
    // Core TTS functionality
    void initializeTTS();
    void updateAvailableLanguages();
    void updateVoices();
    
    // Language detection implementation
    QString detectLanguageInternal(const QString &text);
    bool containsChinese(const QString &text);
    bool containsJapanese(const QString &text);
    bool containsKorean(const QString &text);
    bool containsArabic(const QString &text);
    bool containsRussian(const QString &text);
    
    // Voice selection helpers
    QVoice findBestVoiceForLanguage(const QString &languageCode);
    QLocale findLocaleForLanguage(const QString &languageCode);

    // Queue management
    struct SpeechRequest {
        QString text;
        QString detectedLanguage;
        QLocale targetLocale;
        QVoice targetVoice;
    };
    
    void enqueueSpeech(const QString &text, const QString &language);
    void speakNext();

    // Member variables
    QTextToSpeech *m_tts;
    bool m_isEnabled;
    bool m_isSpeaking;
    
    QStringList m_voiceNames;
    QList<QVoice> m_availableVoices;
    QStringList m_availableLanguages;
    QList<QLocale> m_availableLocales;
    
    QString m_currentLanguage;
    QVoice m_currentVoice;
    QLocale m_currentLocale;
    
    double m_rate;
    double m_pitch;
    double m_volume;
    
    // Speech queue for handling multiple requests
    QQueue<SpeechRequest> m_speechQueue;
    QTimer *m_queueTimer;
    
    // Language detection patterns
    QRegularExpression m_chinesePattern;
    QRegularExpression m_japanesePattern;
    QRegularExpression m_koreanPattern;
    QRegularExpression m_arabicPattern;
    QRegularExpression m_russianPattern;
    QRegularExpression m_englishPattern;
};

#endif // TTSMANAGER_H 