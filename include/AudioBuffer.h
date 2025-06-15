#pragma once

#include <QIODevice>
#include <QByteArray>

/**
 * Custom audio buffer class to capture audio data
 * Separated from VoiceRecognitionManager to avoid MOC compilation issues
 */
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