#pragma once

#include <QObject>
#include <QString>
#include <QJsonObject>
#include <QPdfWriter>
#include <QPainter>
#include <QTextDocument>
#include <QPageLayout>
#include <QPrinter>
#include <memory>

class PDFGenerator : public QObject
{
    Q_OBJECT

public:
    explicit PDFGenerator(QObject *parent = nullptr);
    ~PDFGenerator();

    // Generate PDF from HTML content
    void generateFromHtml(const QString &htmlContent, const QString &outputPath);
    
    // Generate PDF from template and JSON data
    void generateFromTemplate(const QString &templatePath, const QJsonObject &data, const QString &outputPath);
    
    // Configure PDF settings
    void setPaperSize(QPageSize::PageSizeId pageSize);
    void setOrientation(QPageLayout::Orientation orientation);
    void setMargins(const QMarginsF &margins);
    void setResolution(int dpi);

signals:
    void pdfGenerated(const QString &filePath, bool success, const QString &error);
    void generationProgress(int percentage);

private slots:
    void onGenerationFinished(bool success);

private:
    void setupPdfWriter();
    QString loadTemplateFile(const QString &templatePath);
    QString fillTemplateWithData(const QString &templateContent, const QJsonObject &data);
    QString processComplexStructures(const QString &templateContent, const QJsonObject &data);
    QString formatTableRows(const QJsonObject &data);
    QString escapeHtml(const QString &text);
    void generatePdfFromHtml(const QString &htmlContent, const QString &outputPath);
    
    std::unique_ptr<QPdfWriter> m_pdfWriter;
    std::unique_ptr<QTextDocument> m_document;
    std::unique_ptr<QPainter> m_painter;
    
    QString m_currentOutputPath;
    QString m_currentHtmlContent;
    bool m_isGenerating;
    
    // PDF Settings
    QPageSize::PageSizeId m_pageSize;
    QPageLayout::Orientation m_orientation;
    QMarginsF m_margins;
    int m_resolution;
}; 