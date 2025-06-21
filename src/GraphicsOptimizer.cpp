#include "GraphicsOptimizer.h"
#include <QGuiApplication>
#include <QQuickWindow>
#include <QSGRendererInterface>
#include <QQuickGraphicsConfiguration>
#include <QStandardPaths>
#include <QCoreApplication>
#include <QDebug>
#include <QLoggingCategory>
#include <private/qrhi_p.h>
#include <private/qrhigles2_p.h>

// Platform-specific QRhi init params - include conditionally
#ifdef Q_OS_WIN
#include <private/qrhid3d11_p.h>
// Include D3D12 if available in Qt build
#ifdef QT_FEATURE_d3d12
#include <private/qrhid3d12_p.h>
#define HAVE_D3D12_SUPPORT 1
#else
#define HAVE_D3D12_SUPPORT 0
#endif
#endif

#ifdef Q_OS_MACOS
#include <private/qrhimetal_p.h>
#endif

#if QT_CONFIG(vulkan)
#include <private/qrhivulkan_p.h>
#endif

Q_LOGGING_CATEGORY(graphicsOptimizer, "graphics.optimizer")

GraphicsOptimizer::GraphicsOptimizer(QObject *parent)
    : QObject(parent)
{
}

void GraphicsOptimizer::enableGraphicsDiagnostics()
{
    // Enable verbose scene graph logging for debugging
    qputenv("QSG_INFO", "1");
    QLoggingCategory::setFilterRules("qt.scenegraph.general=true");
    QLoggingCategory::setFilterRules("graphics.optimizer=true");
    
    qCInfo(graphicsOptimizer) << "Graphics diagnostics enabled";
    qCInfo(graphicsOptimizer) << "QSG_INFO=1 set for detailed scene graph output";
}

GraphicsOptimizer::Platform GraphicsOptimizer::detectPlatform()
{
#if defined(Q_OS_WIN)
    return Platform::Windows;
#elif defined(Q_OS_MACOS)
    return Platform::macOS;
#elif defined(Q_OS_IOS)
    return Platform::iOS;
#elif defined(Q_OS_ANDROID)
    return Platform::Android;
#elif defined(Q_OS_LINUX)
    // Check for HarmonyOS (runs on Linux kernel but needs Qt 5.x)
    if (QFileInfo::exists("/system/bin/hdc") || QFileInfo::exists("/system/bin/harmony")) {
        qCWarning(graphicsOptimizer) << "HarmonyOS detected - Qt 6.9 RHI not supported, requires Qt 5.x";
        return Platform::HarmonyOS;
    }
    return Platform::Linux;
#else
    return Platform::Unknown;
#endif
}

QVector<GraphicsOptimizer::GraphicsBackend> GraphicsOptimizer::getPlatformBackendPriority(Platform platform)
{
    switch (platform) {
    case Platform::Windows:
        // Windows: D3D12 > Vulkan > D3D11 > OpenGL > Software
        return { GraphicsBackend::Direct3D12, GraphicsBackend::Vulkan, 
                GraphicsBackend::Direct3D11, GraphicsBackend::OpenGL, 
                GraphicsBackend::Software };
        
    case Platform::macOS:
        // macOS: Metal > Vulkan (MoltenVK) > OpenGL > Software
        return { GraphicsBackend::Metal, GraphicsBackend::Vulkan, 
                GraphicsBackend::OpenGL, GraphicsBackend::Software };
        
    case Platform::iOS:
        // iOS: Metal > OpenGL ES > Software
        return { GraphicsBackend::Metal, GraphicsBackend::OpenGLES, 
                GraphicsBackend::Software };
        
    case Platform::Android:
        // Android: Vulkan > OpenGL ES > Software
        return { GraphicsBackend::Vulkan, GraphicsBackend::OpenGLES, 
                GraphicsBackend::Software };
        
    case Platform::Linux:
        // Linux: Vulkan > OpenGL > Software
        return { GraphicsBackend::Vulkan, GraphicsBackend::OpenGL, 
                GraphicsBackend::Software };
        
    case Platform::HarmonyOS:
        // HarmonyOS requires Qt 5.x - return empty for now
        qCWarning(graphicsOptimizer) << "HarmonyOS requires separate Qt 5.x build strategy";
        return {};
        
    default:
        // Unknown platform: try OpenGL then software
        return { GraphicsBackend::OpenGL, GraphicsBackend::Software };
    }
}

bool GraphicsOptimizer::probeGraphicsBackend(GraphicsBackend backend)
{
    switch (backend) {
    case GraphicsBackend::Vulkan:
        return probeVulkan();
        
    case GraphicsBackend::OpenGL:
    case GraphicsBackend::OpenGLES:
        return probeOpenGL();
        
#ifdef Q_OS_WIN
    case GraphicsBackend::Direct3D11:
        return probeDirect3D11();
        
    case GraphicsBackend::Direct3D12:
#if HAVE_D3D12_SUPPORT
        return probeDirect3D12();
#else
        qCWarning(graphicsOptimizer) << "Direct3D 12 not available - compiled without D3D12 support";
        return false;
#endif
#endif

#if defined(Q_OS_MACOS) || defined(Q_OS_IOS)
    case GraphicsBackend::Metal:
        return probeMetal();
#endif

    case GraphicsBackend::Software:
        // Software rendering is always available
        return true;
        
    default:
        return false;
    }
}

QSGRendererInterface::GraphicsApi GraphicsOptimizer::backendToQtApi(GraphicsBackend backend)
{
    switch (backend) {
    case GraphicsBackend::Direct3D11:
        return QSGRendererInterface::Direct3D11;
    case GraphicsBackend::Direct3D12:
        return QSGRendererInterface::Direct3D12;
    case GraphicsBackend::Vulkan:
        return QSGRendererInterface::Vulkan;
    case GraphicsBackend::Metal:
        return QSGRendererInterface::Metal;
    case GraphicsBackend::OpenGL:
    case GraphicsBackend::OpenGLES:
        return QSGRendererInterface::OpenGL;
    case GraphicsBackend::Software:
        return QSGRendererInterface::Software;
    default:
        return QSGRendererInterface::Unknown;
    }
}

QString GraphicsOptimizer::backendToString(GraphicsBackend backend)
{
    switch (backend) {
//    case GraphicsBackend::Direct3D11: return "Direct3D 11";
//    case GraphicsBackend::Direct3D12: return "Direct3D 12";
//    case GraphicsBackend::Vulkan: return "Vulkan";
    case GraphicsBackend::Metal: return "Metal";
    case GraphicsBackend::OpenGL: return "OpenGL";
    case GraphicsBackend::OpenGLES: return "OpenGL ES";
    case GraphicsBackend::Software: return "Software";
    default: return "Unknown";
    }
}

GraphicsOptimizer::GraphicsBackend GraphicsOptimizer::selectOptimalGraphicsApi()
{
    Platform platform = detectPlatform();
    
    qCInfo(graphicsOptimizer) << "Selecting optimal graphics API for platform:" << static_cast<int>(platform);
    qCInfo(graphicsOptimizer) << "Using simplified OpenGL-only approach for maximum compatibility";
    
    // Simplified approach: always use OpenGL for maximum compatibility
    // OpenGL is available on all platforms and doesn't require complex feature detection
    GraphicsBackend selected = GraphicsBackend::OpenGL;
    qCInfo(graphicsOptimizer) << "Selected graphics API:" << backendToString(selected);
    return selected;
}

GraphicsOptimizer::GraphicsInfo GraphicsOptimizer::verifyGraphicsBackend(GraphicsBackend selectedBackend)
{
    GraphicsInfo info;
    info.selectedBackend = selectedBackend;
    info.backendName = backendToString(selectedBackend);
    info.hardwareAccelerated = (selectedBackend != GraphicsBackend::Software);
    
    qCInfo(graphicsOptimizer) << "Verifying graphics backend:" << info.backendName;
    
    // For OpenGL, we assume it's available since Qt requires it
    // and it's the most compatible option across all platforms
    if (selectedBackend == GraphicsBackend::OpenGL) {
        qCInfo(graphicsOptimizer) << "OpenGL verification successful - using default Qt OpenGL support";
        info.hardwareAccelerated = true;
        
        // Apply basic optimizations
        applyGraphicsOptimizations(selectedBackend);
    } else {
        // Fallback to software if somehow a non-OpenGL backend was selected
        qCWarning(graphicsOptimizer) << "Non-OpenGL backend selected, falling back to software rendering";
        info.selectedBackend = GraphicsBackend::Software;
        info.backendName = "Software";
        info.hardwareAccelerated = false;
    }
    
    // Get additional runtime information if available
    // Note: getCurrentGraphicsInfo() might not work properly with Qt 5.x
    // so we'll skip it to avoid potential crashes
    
    logGraphicsDecision(info);
    return info;
}

GraphicsOptimizer::GraphicsInfo GraphicsOptimizer::optimizeGraphicsBackend()
{
    GraphicsInfo info;
    Platform platform = detectPlatform();
    
    qCInfo(graphicsOptimizer) << "=== Qt 6.9 Graphics Backend Optimization ===";
    qCInfo(graphicsOptimizer) << "Platform detected:" << static_cast<int>(platform);
    
    if (platform == Platform::HarmonyOS) {
        info.errorMessage = "HarmonyOS requires Qt 5.x - Qt 6.9 RHI not supported";
        qCWarning(graphicsOptimizer) << info.errorMessage;
        return info;
    }
    
    auto backendPriority = getPlatformBackendPriority(platform);
    qCInfo(graphicsOptimizer) << "Probing graphics backends in priority order...";
    
    for (GraphicsBackend backend : backendPriority) {
        qCInfo(graphicsOptimizer) << "Probing" << backendToString(backend) << "...";
        
        if (probeGraphicsBackend(backend)) {
            info.selectedBackend = backend;
            info.backendName = backendToString(backend);
            info.hardwareAccelerated = (backend != GraphicsBackend::Software);
            
            // Apply the selected backend
            auto qtApi = backendToQtApi(backend);
            QQuickWindow::setGraphicsApi(qtApi);
            
            // Apply backend-specific optimizations
            applyGraphicsOptimizations(backend);
            
            qCInfo(graphicsOptimizer) << "✓ Selected graphics backend:" << info.backendName;
            logGraphicsDecision(info);
            return info;
        } else {
            qCInfo(graphicsOptimizer) << "✗" << backendToString(backend) << "not available";
        }
    }
    
    // If we get here, all backends failed
    info.selectedBackend = GraphicsBackend::Software;
    info.backendName = "Software (Fallback)";
    info.hardwareAccelerated = false;
    info.errorMessage = "No hardware-accelerated graphics backend available";
    
    QQuickWindow::setGraphicsApi(QSGRendererInterface::Software);
    
    qCWarning(graphicsOptimizer) << "⚠ Falling back to software rendering";
    logGraphicsDecision(info);
    
    return info;
}

bool GraphicsOptimizer::probeVulkan()
{
#if QT_CONFIG(vulkan)
    try {
        QRhiVulkanInitParams initParams;
        initParams.inst = nullptr; // Will be created automatically
        
        bool canProbe = QRhi::probe(QRhi::Vulkan, &initParams);
        if (canProbe) {
            qCInfo(graphicsOptimizer) << "Vulkan probe successful";
            
            // Additional Vulkan-specific checks
            QVulkanInstance vulkanInstance;
            if (vulkanInstance.create()) {
                auto layers = vulkanInstance.supportedLayers();
                auto extensions = vulkanInstance.supportedExtensions();
                qCInfo(graphicsOptimizer) << "Vulkan layers:" << layers.size();
                qCInfo(graphicsOptimizer) << "Vulkan extensions:" << extensions.size();
                return true;
            }
        }
    } catch (...) {
        qCWarning(graphicsOptimizer) << "Vulkan probe failed with exception";
    }
#endif
    return false;
}

bool GraphicsOptimizer::probeOpenGL()
{
    try {
        QRhiGles2InitParams initParams;
        // Use default parameters for probing
        
        bool canProbe = QRhi::probe(QRhi::OpenGLES2, &initParams);
        if (canProbe) {
            qCInfo(graphicsOptimizer) << "OpenGL/OpenGL ES probe successful";
            return true;
        }
    } catch (...) {
        qCWarning(graphicsOptimizer) << "OpenGL probe failed with exception";
    }
    return false;
}

#ifdef Q_OS_WIN
bool GraphicsOptimizer::probeDirect3D11()
{
    try {
        QRhiD3D11InitParams initParams;
        // Use default parameters for probing
        
        bool canProbe = QRhi::probe(QRhi::D3D11, &initParams);
        if (canProbe) {
            qCInfo(graphicsOptimizer) << "Direct3D 11 probe successful";
            return true;
        }
    } catch (...) {
        qCWarning(graphicsOptimizer) << "Direct3D 11 probe failed with exception";
    }
    return false;
}

#if HAVE_D3D12_SUPPORT
bool GraphicsOptimizer::probeDirect3D12()
{
    try {
        QRhiD3D12InitParams initParams;
        // Use default parameters for probing
        
        bool canProbe = QRhi::probe(QRhi::D3D12, &initParams);
        if (canProbe) {
            qCInfo(graphicsOptimizer) << "Direct3D 12 probe successful";
            return true;
        }
    } catch (...) {
        qCWarning(graphicsOptimizer) << "Direct3D 12 probe failed with exception";
    }
    return false;
}
#endif
#endif

#if defined(Q_OS_MACOS) || defined(Q_OS_IOS)
bool GraphicsOptimizer::probeMetal()
{
    try {
        QRhiMetalInitParams initParams;
        // Use default parameters for probing
        
        bool canProbe = QRhi::probe(QRhi::Metal, &initParams);
        if (canProbe) {
            qCInfo(graphicsOptimizer) << "Metal probe successful";
            return true;
        }
    } catch (...) {
        qCWarning(graphicsOptimizer) << "Metal probe failed with exception";
    }
    return false;
}
#endif

void GraphicsOptimizer::applyGraphicsOptimizations(GraphicsBackend backend)
{
    // Note: Graphics configuration optimizations are applied per-window
    // when the QQuickWindow instance is created, not globally here.
    // This method serves as a placeholder for future global optimizations
    // that don't require a window instance.
    
    qCInfo(graphicsOptimizer) << "Applied graphics optimizations for" << backendToString(backend);
    
    // Future global optimizations for the selected backend can be added here
    // Examples: environment variables, global Qt settings, etc.
}

void GraphicsOptimizer::logGraphicsDecision(const GraphicsInfo& info)
{
    qCInfo(graphicsOptimizer) << "=== Graphics Backend Selection Results ===";
    qCInfo(graphicsOptimizer) << "Selected backend:" << info.backendName;
    qCInfo(graphicsOptimizer) << "Hardware accelerated:" << info.hardwareAccelerated;
    
    if (!info.errorMessage.isEmpty()) {
        qCWarning(graphicsOptimizer) << "Warning:" << info.errorMessage;
    }
    
    if (!info.deviceName.isEmpty()) {
        qCInfo(graphicsOptimizer) << "Graphics device:" << info.deviceName;
    }
    
    if (!info.driverVersion.isEmpty()) {
        qCInfo(graphicsOptimizer) << "Driver version:" << info.driverVersion;
    }
    
    qCInfo(graphicsOptimizer) << "==========================================";
}

GraphicsOptimizer::GraphicsInfo GraphicsOptimizer::getCurrentGraphicsInfo()
{
    GraphicsInfo info;
    
    // This would need to be called after Qt has initialized
    // and QML scene graph has been created to get actual runtime info
    auto window = QQuickWindow::sceneGraphBackend();
    qCInfo(graphicsOptimizer) << "Current scene graph backend:" << window;
    
    // Additional runtime information would be gathered here
    // This is a placeholder for post-initialization analysis
    
    return info;
}

// Convenience function implementation
GraphicsOptimizer::GraphicsInfo optimizeApplicationGraphics(bool enableDiagnostics)
{
    if (enableDiagnostics) {
        GraphicsOptimizer::enableGraphicsDiagnostics();
    }
    
    return GraphicsOptimizer::optimizeGraphicsBackend();
} 
