#pragma once

#include <QObject>
#include <QString>
#include <QPixmap>
#include <QImage>

class QRCodeGenerator : public QObject
{
    Q_OBJECT

public:
    explicit QRCodeGenerator(QObject *parent = nullptr);
    ~QRCodeGenerator();

    // Generate QR code as image
    QPixmap generateQRCode(const QString &text, int size = 256) const;
    
    // Generate QR code as base64 data URI for QML
    QString generateQRCodeDataURI(const QString &text, int size = 256) const;
    
    // Check if QR code generation is available
    bool isAvailable() const;

public slots:
    // Generate QR code asynchronously
    void generateQRCodeAsync(const QString &text, int size = 256);

signals:
    void qrCodeGenerated(const QString &dataURI);
    void qrCodeError(const QString &error);

private:
    // Simple ASCII QR code fallback
    QString generateSimpleQRCode(const QString &text) const;
    
    // Create QR code pattern manually (basic implementation)
    QImage createQRCodeImage(const QString &text, int size) const;
    
    // Helper methods for QR code drawing
    void drawCornerMarker(QPainter *painter, int x, int y, int size) const;
    
    // Error correction and encoding helpers
    QByteArray encodeText(const QString &text) const;
    QVector<bool> addErrorCorrection(const QVector<bool> &data) const;
    
    bool m_available;
}; 