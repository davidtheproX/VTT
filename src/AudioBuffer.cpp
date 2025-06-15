#include "AudioBuffer.h"
#include <QDebug>
#include <QtMath>

AudioBuffer::AudioBuffer(QObject *parent)
    : QIODevice(parent)
    , m_isRecording(false)
{
}

void AudioBuffer::startRecording()
{
    m_isRecording = true;
    m_buffer.clear();
    open(QIODevice::WriteOnly);
    qDebug() << "AudioBuffer: Started recording";
}

void AudioBuffer::stopRecording()
{
    m_isRecording = false;
    close();
    qDebug() << "AudioBuffer: Stopped recording, buffer size:" << m_buffer.size();
}

QByteArray AudioBuffer::getRecordedData() const
{
    return m_buffer;
}

void AudioBuffer::clearBuffer()
{
    m_buffer.clear();
}

qint64 AudioBuffer::readData(char *data, qint64 maxlen)
{
    Q_UNUSED(data)
    Q_UNUSED(maxlen)
    return 0; // We don't read from this buffer
}

qint64 AudioBuffer::writeData(const char *data, qint64 len)
{
    if (m_isRecording && data && len > 0) {
        m_buffer.append(data, len);
        
        // Calculate and emit audio level
        float level = calculateAudioLevel(data, len);
        emit audioLevelUpdated(level);
        
        return len;
    }
    return 0;
}

float AudioBuffer::calculateAudioLevel(const char *data, qint64 len)
{
    if (!data || len <= 0) {
        return 0.0f;
    }
    
    // Assume 16-bit signed PCM audio
    const qint16 *samples = reinterpret_cast<const qint16*>(data);
    qint64 sampleCount = len / sizeof(qint16);
    
    qint64 sum = 0;
    for (qint64 i = 0; i < sampleCount; ++i) {
        sum += qAbs(samples[i]);
    }
    
    if (sampleCount > 0) {
        float average = static_cast<float>(sum) / sampleCount;
        // Normalize to 0.0 - 1.0 range (16-bit max is 32767)
        return qMin(1.0f, average / 32767.0f);
    }
    
    return 0.0f;
} 