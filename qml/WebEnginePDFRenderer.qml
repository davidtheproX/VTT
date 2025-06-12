import QtQuick
import QtWebEngine

Item {
    id: root
    width: 794  // A4 width in pixels at 96 DPI
    height: 1123 // A4 height in pixels at 96 DPI
    visible: false // Keep hidden during rendering
    
    property string htmlContent: ""
    property bool isRendering: false
    property real renderProgress: 0.0
    
    // Signals
    signal renderCompleted(var imageData)
    signal renderFailed(string error)
    signal progressChanged(real progress)
    
    // Configure for PDF-optimized rendering
    WebEngineView {
        id: webView
        anchors.fill: parent
        
        // Optimize settings for PDF rendering
        settings.javascriptEnabled: true
        settings.localContentCanAccessRemoteUrls: false
        settings.localContentCanAccessFileUrls: true
        settings.allowRunningInsecureContent: false
        settings.dnsPrefetchEnabled: false
        settings.pluginsEnabled: false
        
        // Print/PDF specific settings
        settings.printElementBackgrounds: true
        settings.pdfViewerEnabled: false
        
        // Performance settings for rendering
        settings.accelerated2dCanvasEnabled: true
        settings.webGLEnabled: false  // Disable for consistent PDF output
        settings.hyperlinkAuditingEnabled: false
        settings.fullScreenSupportEnabled: false
        
        onLoadingChanged: {
            console.log("WebEngine loading changed - status:", loadRequest.status, "progress:", loadProgress)
            
            if (loadRequest.status === WebEngineView.LoadStartedStatus) {
                root.isRendering = true
                root.renderProgress = 0.0
                root.progressChanged(0.0)
            }
            else if (loadRequest.status === WebEngineView.LoadSucceededStatus) {
                console.log("WebEngine load succeeded, starting render capture")
                root.renderProgress = 0.8
                root.progressChanged(0.8)
                
                // Wait a bit for CSS animations and dynamic content to settle
                renderTimer.start()
            }
            else if (loadRequest.status === WebEngineView.LoadFailedStatus) {
                console.error("WebEngine load failed:", loadRequest.errorString)
                root.isRendering = false
                root.renderProgress = 0.0
                root.renderFailed("Failed to load HTML content: " + loadRequest.errorString)
            }
        }
        
        onLoadProgressChanged: {
            if (isRendering && loadProgress < 80) {
                root.renderProgress = loadProgress / 100.0 * 0.8
                root.progressChanged(root.renderProgress)
            }
        }
        
        onJavaScriptConsoleMessage: {
            console.log("WebEngine JS Console:", level, message, lineNumber, sourceID)
        }
    }
    
    // Timer to ensure content is fully rendered before capture
    Timer {
        id: renderTimer
        interval: 1000  // Wait 1 second for content to settle
        repeat: false
        
        onTriggered: {
            console.log("Capturing rendered content")
            captureRenderedContent()
        }
    }
    
    // Fallback timer for rendering timeout
    Timer {
        id: timeoutTimer
        interval: 30000  // 30 second timeout
        repeat: false
        running: false
        
        onTriggered: {
            if (root.isRendering) {
                console.error("WebEngine rendering timeout")
                root.isRendering = false
                root.renderProgress = 0.0
                root.renderFailed("Rendering timeout - content took too long to load")
            }
        }
    }
    
    // Functions
    function renderHtml(htmlContent) {
        console.log("Starting WebEngine HTML render, content length:", htmlContent.length)
        
        if (root.isRendering) {
            console.warn("Already rendering, ignoring new request")
            return false
        }
        
        if (!htmlContent || htmlContent.trim().length === 0) {
            console.error("Empty HTML content provided")
            root.renderFailed("Empty HTML content")
            return false
        }
        
        root.htmlContent = htmlContent
        root.isRendering = true
        root.renderProgress = 0.0
        
        // Start timeout timer
        timeoutTimer.start()
        
        // Load the HTML content
        try {
            webView.loadHtml(htmlContent, "file:///")
            return true
        } catch (e) {
            console.error("Error loading HTML:", e)
            root.isRendering = false
            root.renderProgress = 0.0
            timeoutTimer.stop()
            root.renderFailed("Error loading HTML: " + e.toString())
            return false
        }
    }
    
    function captureRenderedContent() {
        console.log("Attempting to capture WebEngine content")
        
        try {
            root.renderProgress = 0.9
            root.progressChanged(0.9)
            
            // Grab the webview content as an image
            webView.grabToImage(function(result) {
                console.log("WebEngine content captured successfully")
                
                root.isRendering = false
                root.renderProgress = 1.0
                timeoutTimer.stop()
                
                root.progressChanged(1.0)
                root.renderCompleted(result)
            }, Qt.size(root.width, root.height))
            
        } catch (e) {
            console.error("Error capturing content:", e)
            root.isRendering = false
            root.renderProgress = 0.0
            timeoutTimer.stop()
            root.renderFailed("Error capturing rendered content: " + e.toString())
        }
    }
    
    function cancelRendering() {
        console.log("Cancelling WebEngine rendering")
        
        if (root.isRendering) {
            root.isRendering = false
            root.renderProgress = 0.0
            timeoutTimer.stop()
            renderTimer.stop()
            
            // Stop the web view loading
            webView.stop()
        }
    }
    
    // Component destruction cleanup
    Component.onDestruction: {
        cancelRendering()
    }
} 