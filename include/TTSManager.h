#pragma once

#include <QObject>
#include <QString>
#include <QStringList>
#include <QTextToSpeech>
#include <QVoice>
#include <QTimer>
#include <QVariant>
#include <QtQmlIntegration>
#include <memory>

class TTSManager : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    Q_PROPERTY(bool isEnabled READ isEnabled WRITE setIsEnabled NOTIFY enabledChanged)
    Q_PROPERTY(bool isSpeaking READ isSpeaking NOTIFY speakingChanged)
    Q_PROPERTY(QStringList availableVoices READ availableVoices NOTIFY availableVoicesChanged)
    Q_PROPERTY(QString currentVoice READ currentVoice WRITE setCurrentVoice NOTIFY currentVoiceChanged)
    Q_PROPERTY(qreal rate READ rate WRITE setRate NOTIFY rateChanged)
    Q_PROPERTY(qreal pitch READ pitch WRITE setPitch NOTIFY pitchChanged)
    Q_PROPERTY(qreal volume READ volume WRITE setVolume NOTIFY volumeChanged)
    Q_PROPERTY(QTextToSpeech::State state READ state NOTIFY stateChanged)

public:
    explicit TTSManager(QObject *parent = nullptr);
    ~TTSManager();

    // Properties
    bool isEnabled() const { return m_isEnabled; }
    void setIsEnabled(bool enabled);

    bool isSpeaking() const;
    
    QStringList availableVoices() const { return m_availableVoices; }
    QString currentVoice() const { return m_currentVoiceName; }
    void setCurrentVoice(const QString &voiceName);

    QTextToSpeech::State state() const;

    double rate() const;
    void setRate(double rate);

    double pitch() const;
    void setPitch(double pitch);

    double volume() const;
    void setVolume(double volume);

    // Voice presets
    Q_INVOKABLE void applyJarvisVoicePreset();
    Q_INVOKABLE void applyNaturalVoicePreset();
    Q_INVOKABLE void applyRobotVoicePreset();
    Q_INVOKABLE void applyChineseVoicePreset();

public slots:
    void speak(const QString &text);
    void stop();
    void pause();
    void resume();
    void initialize();
    void refreshVoices();  // Add manual refresh function

signals:
    void enabledChanged();
    void speakingChanged();
    void availableVoicesChanged();
    void currentVoiceChanged();
    void rateChanged();
    void pitchChanged();
    void volumeChanged();
    void stateChanged(QTextToSpeech::State state);
    void error(const QString &errorMessage);

private slots:
    void onStateChanged(QTextToSpeech::State state);
    void onErrorOccurred(QTextToSpeech::ErrorReason reason, const QString &errorString);

private:
    void loadAvailableVoices();
    void findBestVoiceForPreset(const QString &preferredName, const QString &preferredGender);
    QVoice findVoiceByName(const QString &name) const;
    QString getVoiceDisplayName(const QVoice &voice) const;
    bool containsChinese(const QString &text);
    bool findChineseVoice();

    QTextToSpeech *m_tts;
    bool m_isEnabled;
    QStringList m_availableVoices;
    QString m_currentVoiceName;
    QList<QVoice> m_voices;
    
    // Voice presets
    struct VoicePreset {
        QString name;
        double rate;
        double pitch;
        double volume;
        QString preferredVoiceName;
        QString preferredGender;
    };
    
    static const VoicePreset JARVIS_PRESET;
    static const VoicePreset NATURAL_PRESET;
    static const VoicePreset ROBOT_PRESET;
    static const VoicePreset CHINESE_PRESET;
}; 