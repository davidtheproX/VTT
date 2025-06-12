#pragma once

#include <QObject>
#include <QTimer>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QAudioInput>
#include <QMediaDevices>
#include <QAudioDevice>
#include <QIODevice>
#include <QByteArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QMediaCaptureSession>
#include <QAudioSource>
#include <QAudioFormat>
#include <QtQmlIntegration>
#include <memory>

class AudioBuffer;

class VoiceRecognitionManager : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    Q_PROPERTY(bool isListening READ isListening NOTIFY listeningChanged)
    Q_PROPERTY(bool isRecording READ isRecording NOTIFY recordingChanged)
    Q_PROPERTY(QString recognizedText READ recognizedText NOTIFY recognizedTextChanged)
    Q_PROPERTY(qreal audioLevel READ audioLevel NOTIFY audioLevelChanged)
    Q_PROPERTY(bool isConfigured READ isConfigured NOTIFY configurationChanged)
    Q_PROPERTY(QStringList availableDevices READ availableDevices NOTIFY availableDevicesChanged)
    Q_PROPERTY(QString currentDevice READ currentDevice WRITE setCurrentDevice NOTIFY currentDeviceChanged)
    Q_PROPERTY(QString googleApiKey READ googleApiKey WRITE setGoogleApiKey NOTIFY googleApiKeyChanged)
    Q_PROPERTY(QStringList availableMicrophones READ availableMicrophones NOTIFY availableMicrophonesChanged)
    Q_PROPERTY(QString currentMicrophone READ currentMicrophone WRITE setCurrentMicrophone NOTIFY currentMicrophoneChanged)
    Q_PROPERTY(bool isTesting READ isTesting NOTIFY isTestingChanged)

public:
    explicit VoiceRecognitionManager(QObject *parent = nullptr);
    ~VoiceRecognitionManager();

    // Property getters
    bool isListening() const { return m_isListening; }
    bool isRecording() const { return m_isRecording; }
    QString recognizedText() const { return m_recognizedText; }
    qreal audioLevel() const { return m_audioLevel; }
    bool isConfigured() const { return m_isConfigured; }
    QStringList availableDevices() const { return m_availableDevices; }
    QString currentDevice() const { return m_currentDevice; }
    QString googleApiKey() const { return m_googleApiKey; }
    QStringList availableMicrophones() const { return m_availableMicrophones; }
    QString currentMicrophone() const { return m_currentMicrophone; }
    bool isTesting() const { return m_isTesting; }

    // Property setters
    void setGoogleApiKey(const QString &apiKey);
    void setCurrentMicrophone(const QString &microphoneName);
    void setCurrentDevice(const QString &deviceName);

public slots:
    void startListening();
    void stopListening();
    void toggleListening();
    void refreshMicrophones();
    void startMicrophoneTest();
    void stopMicrophoneTest();

signals:
    void listeningChanged();
    void recordingChanged();
    void recognizedTextChanged();
    void audioLevelChanged();
    void configurationChanged();
    void availableDevicesChanged();
    void currentDeviceChanged();
    void textRecognized(const QString &text);
    void error(const QString &errorMessage);
    void googleApiKeyChanged();
    void availableMicrophonesChanged();
    void currentMicrophoneChanged();
    void isTestingChanged();

private slots:
    void updateAudioLevel();
    void processAudioData();
    void onSpeechRecognitionFinished(QNetworkReply *reply);
    void onNetworkError(QNetworkReply::NetworkError error);

private:
    void initializeAudio();
    void setupAudioInput();
    void sendToGoogleSpeechAPI(const QByteArray &audioData);
    QJsonObject createGoogleSpeechRequest(const QByteArray &audioData);
    void processGoogleSpeechResponse(const QJsonDocument &response);
    void handleRecordingError();
    void loadAvailableMicrophones();
    QAudioDevice findMicrophoneByName(const QString &name) const;
    QString getMicrophoneDisplayName(const QAudioDevice &device) const;

    // Qt6 Audio recording components
    QMediaCaptureSession *m_captureSession;
    QAudioInput *m_audioInput;
    QAudioDevice m_audioDevice;
    QAudioSource *m_audioSource;
    QAudioFormat m_audioFormat;
    AudioBuffer *m_audioBuffer;
    QByteArray m_recordedAudio;
    
    // Network for Google Speech API
    QNetworkAccessManager *m_networkManager;
    QNetworkReply *m_currentReply;
    
    // Timers
    std::unique_ptr<QTimer> m_audioLevelTimer;
    std::unique_ptr<QTimer> m_recordingTimer;
    
    // State
    bool m_isListening;
    bool m_isRecording;
    qreal m_audioLevel;
    QString m_recognizedText;
    QString m_googleApiKey;
    
    // Microphone management
    QStringList m_availableMicrophones;
    QString m_currentMicrophone;
    QList<QAudioDevice> m_audioDevices;
    bool m_isTesting;
    
    // Audio settings
    static constexpr int SAMPLE_RATE = 16000;
    static constexpr int RECORDING_DURATION_MS = 5000; // 5 seconds

    // Additional properties
    bool m_isConfigured;
    QStringList m_availableDevices;
    QString m_currentDevice;
};

// Custom audio buffer class to capture audio data
class AudioBuffer : public QIODevice
{
    Q_OBJECT

public:
    explicit AudioBuffer(QObject *parent = nullptr);
    
    void startRecording();
    void stopRecording();
    QByteArray getRecordedData() const;
    void clearBuffer();

signals:
    void audioLevelUpdated(float level);

protected:
    qint64 readData(char *data, qint64 maxlen) override;
    qint64 writeData(const char *data, qint64 len) override;

private:
    QByteArray m_buffer;
    bool m_isRecording;
    float calculateAudioLevel(const char *data, qint64 len);
}; 