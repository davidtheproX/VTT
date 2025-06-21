#ifndef GRAPHICSOPTIMIZER_H
#define GRAPHICSOPTIMIZER_H

#include <QObject>
#include <QGuiApplication>
#include <QQuickWindow>
#include <QSGRendererInterface>
#include <QDebug>
#include <QLoggingCategory>

// Forward declarations for RHI types to avoid header dependency issues
class QRhi;
class QRhiInitParams;

#if QT_CONFIG(vulkan)
#include <QVulkanInstance>
#endif

Q_DECLARE_LOGGING_CATEGORY(graphicsOptimizer)

/**
 * @brief Graphics backend optimizer for Qt 6.9 cross-platform applications
 * 
 * Implements intelligent graphics API selection using Qt's RHI system.
 * Supports Windows (D3D11/12, Vulkan, OpenGL), macOS (Metal, Vulkan, OpenGL),
 * Linux (Vulkan, OpenGL), Android (Vulkan, OpenGL ES), and iOS (Metal, OpenGL ES).
 * 
 * Based on Qt 6.9 RHI architecture and cross-platform optimization strategies.
 */
class GraphicsOptimizer : public QObject
{
    Q_OBJECT

public:
    enum class GraphicsBackend {
        Unknown,
        Direct3D11,
        Direct3D12,
        Vulkan,
        Metal,
        OpenGL,
        OpenGLES,
        Software
    };
    Q_ENUM(GraphicsBackend)

    enum class Platform {
        Windows,
        macOS,
        Linux,
        Android,
        iOS,
        HarmonyOS,
        Unknown
    };
    Q_ENUM(Platform)

    struct GraphicsInfo {
        GraphicsBackend selectedBackend = GraphicsBackend::Unknown;
        QString backendName;
        QString deviceName;
        QString driverVersion;
        bool hardwareAccelerated = false;
        bool threaded = false;
        QStringList supportedFeatures;
        QString errorMessage;
    };

    explicit GraphicsOptimizer(QObject *parent = nullptr);

    /**
     * @brief Main entry point for graphics optimization
     * 
     * Must be called early in main() before any QQuickWindow is created.
     * Implements prioritized fallback strategy based on platform capabilities.
     * 
     * @return GraphicsInfo containing selected backend and diagnostics
     */
    static GraphicsInfo optimizeGraphicsBackend();

    /**
     * @brief Select optimal graphics API without probing (for early initialization)
     * 
     * Can be called before QGuiApplication creation. Uses platform heuristics
     * without QRhi probing to select the best graphics API.
     * 
     * @return GraphicsBackend enum for the selected API
     */
    static GraphicsBackend selectOptimalGraphicsApi();

    /**
     * @brief Verify graphics backend selection after QGuiApplication creation
     * 
     * Called after QGuiApplication to verify the selected backend works properly.
     * 
     * @param selectedBackend The backend that was selected
     * @return GraphicsInfo with verification results
     */
    static GraphicsInfo verifyGraphicsBackend(GraphicsBackend selectedBackend);

    /**
     * @brief Enable verbose graphics diagnostics
     * 
     * Sets QSG_INFO=1 and qt.scenegraph.general logging for detailed output.
     * Should be called before QGuiApplication creation for full diagnostics.
     */
    static void enableGraphicsDiagnostics();

    /**
     * @brief Detect current platform
     * @return Platform enum value
     */
    static Platform detectPlatform();

    /**
     * @brief Get platform-specific preferred backend order
     * @param platform Target platform
     * @return Ordered list of backends to try (most preferred first)
     */
    static QVector<GraphicsBackend> getPlatformBackendPriority(Platform platform);

    /**
     * @brief Probe if a specific graphics backend is available
     * @param backend Backend to probe
     * @return true if backend can be successfully initialized
     */
    static bool probeGraphicsBackend(GraphicsBackend backend);

    /**
     * @brief Convert GraphicsBackend to QSGRendererInterface::GraphicsApi
     * @param backend Our backend enum
     * @return Qt's graphics API enum for setGraphicsApi()
     */
    static QSGRendererInterface::GraphicsApi backendToQtApi(GraphicsBackend backend);

    /**
     * @brief Get human-readable name for graphics backend
     * @param backend Backend enum
     * @return Descriptive name string
     */
    static QString backendToString(GraphicsBackend backend);

    /**
     * @brief Get current graphics information after Qt initialization
     * @return GraphicsInfo with runtime details
     */
    static GraphicsInfo getCurrentGraphicsInfo();

private:
    /**
     * @brief Probe Vulkan-specific capabilities
     * @return true if Vulkan is available with required features
     */
    static bool probeVulkan();

    /**
     * @brief Probe OpenGL/OpenGL ES capabilities
     * @return true if OpenGL is available with required features
     */
    static bool probeOpenGL();

#ifdef Q_OS_WIN
    /**
     * @brief Probe Direct3D 11 capabilities (Windows)
     * @return true if D3D11 is available
     */
    static bool probeDirect3D11();

    /**
     * @brief Probe Direct3D 12 capabilities (Windows)
     * @return true if D3D12 is available
     */
    static bool probeDirect3D12();
#endif

#ifdef Q_OS_MACOS
    /**
     * @brief Probe Metal capabilities (macOS/iOS)
     * @return true if Metal is available
     */
    static bool probeMetal();
#endif

    /**
     * @brief Apply graphics configuration optimizations
     * @param backend Selected backend
     */
    static void applyGraphicsOptimizations(GraphicsBackend backend);

    /**
     * @brief Log graphics selection decision
     * @param info Graphics information to log
     */
    static void logGraphicsDecision(const GraphicsInfo& info);
};

/**
 * @brief Convenience function for main.cpp integration
 * 
 * Call this early in main() before QGuiApplication creation for optimal results.
 * Handles both diagnostics enablement and backend selection.
 * 
 * @param enableDiagnostics Whether to enable verbose logging
 * @return GraphicsInfo with selected backend details
 */
GraphicsOptimizer::GraphicsInfo optimizeApplicationGraphics(bool enableDiagnostics = true);

#endif // GRAPHICSOPTIMIZER_H 
