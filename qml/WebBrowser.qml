import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtWebView

Dialog {
    id: root
    title: webComponentLoader.item ? (webComponentLoader.item.title || "Web Browser") : "Web Browser"
    width: 1200
    height: 800
    modal: true
    standardButtons: Dialog.Close
    
    // Web backend detection
    property bool webViewAvailable: false
    property bool webEngineAvailable: false
    property string webBackend: "None"
    property string currentUrl: ""
    
    property real scaleFactor: 1.0
    property color primaryColor: "#2196F3"
    property color backgroundColor: "#f5f5f5"
    property color textColor: "#333333"
    
    // Navigation state (will be bound to the actual web component)
    property bool canGoBack: webComponentLoader.item ? webComponentLoader.item.canGoBack || false : false
    property bool canGoForward: webComponentLoader.item ? webComponentLoader.item.canGoForward || false : false
    property bool isLoading: webComponentLoader.item ? webComponentLoader.item.loading || false : false
    property int loadProgress: webComponentLoader.item ? webComponentLoader.item.loadProgress || 0 : 0
    
    function navigateToUrl(url) {
        if (url && url.length > 0) {
            if (!url.startsWith("http://") && !url.startsWith("https://")) {
                url = "https://" + url
            }
            console.log("Navigating to:", url)
            currentUrl = url
            if (webComponentLoader.item) {
                webComponentLoader.item.url = url
            }
        }
    }
    
    function goBack() {
        if (webComponentLoader.item && webComponentLoader.item.canGoBack) {
            webComponentLoader.item.goBack()
        }
    }
    
    function goForward() {
        if (webComponentLoader.item && webComponentLoader.item.canGoForward) {
            webComponentLoader.item.goForward()
        }
    }
    
    function reload() {
        if (webComponentLoader.item && webComponentLoader.item.reload) {
            webComponentLoader.item.reload()
        }
    }
    
    function stop() {
        if (webComponentLoader.item && webComponentLoader.item.stop) {
            webComponentLoader.item.stop()
        }
    }
    
    // Web backend detection and initialization
    function detectWebBackends() {
        console.log("=== Detecting Web Backends ===")
        
        // Test WebView availability
        try {
            Qt.createQmlObject('import QtWebView; Item {}', root)
            webViewAvailable = true
            console.log("✓ QtWebView available")
        } catch (e) {
            console.log("✗ QtWebView not available:", e.message)
        }
        
        // Test WebEngine availability  
        try {
            Qt.createQmlObject('import QtWebEngine; Item {}', root)
            webEngineAvailable = true
            console.log("✓ QtWebEngine available")
        } catch (e) {
            console.log("✗ QtWebEngine not available:", e.message)
        }
        
        // Determine best backend
        if (Qt.platform.os === "android" || Qt.platform.os === "ios") {
            if (webViewAvailable) {
                webBackend = "WebView"
                console.log("🔥 Using WebView for mobile platform")
            } else {
                webBackend = "None"
                console.log("❌ No web backend available for mobile")
            }
        } else {
            // Desktop platforms (Windows/Linux/macOS)
            if (webEngineAvailable) {
                webBackend = "WebEngine"
                console.log("🔥 Using WebEngine for desktop platform")
            } else if (webViewAvailable) {
                webBackend = "WebView"
                console.log("⚠ Using WebView for desktop (limited functionality)")
            } else {
                webBackend = "None"
                console.log("❌ No web backend available for desktop")
            }
        }
        
        console.log("Selected web backend:", webBackend)
        return webBackend
    }
    
    header: Rectangle {
        width: parent.width
        height: 50 * scaleFactor
        color: backgroundColor
        border.color: Qt.darker(backgroundColor, 1.2)
        border.width: 1
        
        RowLayout {
            anchors.fill: parent
            anchors.margins: 8 * scaleFactor
            spacing: 8 * scaleFactor
            
            // Back button
            Button {
                id: backButton
                text: "◀"
                enabled: root.canGoBack
                implicitWidth: 36 * scaleFactor
                implicitHeight: 36 * scaleFactor
                flat: true
                
                background: Rectangle {
                    color: backButton.pressed ? Qt.darker(primaryColor, 1.3) :
                           backButton.hovered ? Qt.darker(primaryColor, 1.1) : "transparent"
                    radius: 4
                }
                
                contentItem: Text {
                    text: backButton.text
                    color: backButton.enabled ? primaryColor : "#999999"
                    font.pixelSize: 16 * scaleFactor
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                
                ToolTip.text: "Go Back"
                ToolTip.visible: hovered
                
                onClicked: goBack()
            }
            
            // Forward button
            Button {
                id: forwardButton
                text: "▶"
                enabled: root.canGoForward
                implicitWidth: 36 * scaleFactor
                implicitHeight: 36 * scaleFactor
                flat: true
                
                background: Rectangle {
                    color: forwardButton.pressed ? Qt.darker(primaryColor, 1.3) :
                           forwardButton.hovered ? Qt.darker(primaryColor, 1.1) : "transparent"
                    radius: 4
                }
                
                contentItem: Text {
                    text: forwardButton.text
                    color: forwardButton.enabled ? primaryColor : "#999999"
                    font.pixelSize: 16 * scaleFactor
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                
                ToolTip.text: "Go Forward"
                ToolTip.visible: hovered
                
                onClicked: goForward()
            }
            
            // Reload/Stop button
            Button {
                id: reloadButton
                text: root.isLoading ? "⏹" : "🔄"
                implicitWidth: 36 * scaleFactor
                implicitHeight: 36 * scaleFactor
                flat: true
                
                background: Rectangle {
                    color: reloadButton.pressed ? Qt.darker(primaryColor, 1.3) :
                           reloadButton.hovered ? Qt.darker(primaryColor, 1.1) : "transparent"
                    radius: 4
                }
                
                contentItem: Text {
                    text: reloadButton.text
                    color: primaryColor
                    font.pixelSize: 14 * scaleFactor
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                
                ToolTip.text: root.isLoading ? "Stop Loading" : "Reload Page"
                ToolTip.visible: hovered
                
                onClicked: root.isLoading ? stop() : reload()
            }
            
            // Address bar
            TextField {
                id: addressBar
                Layout.fillWidth: true
                Layout.minimumWidth: 200 * scaleFactor
                placeholderText: "Enter URL or search term..."
                text: currentUrl
                
                background: Rectangle {
                    color: "white"
                    border.color: addressBar.focus ? primaryColor : "#cccccc"
                    border.width: 1
                    radius: 4
                }
                
                onAccepted: {
                    navigateToUrl(text)
                }
                
                Keys.onEscapePressed: {
                    text = root.currentUrl
                    focus = false
                }
            }
            
            // Home button
            Button {
                id: homeButton
                text: "🏠"
                implicitWidth: 36 * scaleFactor
                implicitHeight: 36 * scaleFactor
                flat: true
                
                background: Rectangle {
                    color: homeButton.pressed ? Qt.darker(primaryColor, 1.3) :
                           homeButton.hovered ? Qt.darker(primaryColor, 1.1) : "transparent"
                    radius: 4
                }
                
                contentItem: Text {
                    text: homeButton.text
                    color: primaryColor
                    font.pixelSize: 14 * scaleFactor
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                
                ToolTip.text: "Go Home"
                ToolTip.visible: hovered
                
                onClicked: navigateToUrl("https://www.google.com")
            }
        }
    }
    
    // Main content area
    contentItem: Item {
        // Progress bar
        ProgressBar {
            id: progressBar
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: 2 * scaleFactor
            from: 0
            to: 100
            value: root.loadProgress
            visible: root.isLoading
            
            background: Rectangle {
                color: backgroundColor
            }
            
            contentItem: Rectangle {
                color: primaryColor
                radius: 1
            }
        }
        
        // Dynamic Web Component Loader
        Loader {
            id: webComponentLoader
            anchors.top: progressBar.visible ? progressBar.bottom : parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            
            sourceComponent: {
                if (webBackend === "WebEngine") {
                    return webEngineComponent
                } else if (webBackend === "WebView") {
                    return webViewComponent
                } else {
                    return fallbackComponent
                }
            }
            
            onItemChanged: {
                if (item) {
                    console.log("=== Web Component Loaded ===")
                    console.log("Backend:", webBackend)
                    console.log("Component type:", item.toString())
                    
                    // Set up connections for URL updates
                    if (item.urlChanged) {
                        item.urlChanged.connect(function() {
                            currentUrl = item.url
                            addressBar.text = currentUrl
                        })
                    }
                    
                    // Load initial URL if we have one
                    if (currentUrl && currentUrl.length > 0) {
                        item.url = currentUrl
                    } else {
                        item.url = "https://www.google.com"
                    }
                }
            }
        }
        
        // WebEngine Component
        Component {
            id: webEngineComponent
            Item {
                Component.onCompleted: {
                    console.log("=== Creating WebEngine Component ===")
                    var webEngineQml = `
                        import QtWebEngine
                        WebEngineView {
                            anchors.fill: parent
                            
                            onLoadingChanged: function(loadRequest) {
                                console.log("WebEngine loading changed - Status:", loadRequest.status, "URL:", loadRequest.url)
                                if (loadRequest.errorString) {
                                    console.error("WebEngine load error:", loadRequest.errorString)
                                }
                            }
                            
                            onUrlChanged: {
                                console.log("WebEngine URL changed to:", url)
                            }
                            
                            onLoadProgressChanged: {
                                console.log("WebEngine load progress:", loadProgress + "%")
                            }
                            
                            onTitleChanged: {
                                console.log("WebEngine title changed:", title)
                            }
                        }
                    `
                    try {
                        var webEngineView = Qt.createQmlObject(webEngineQml, this)
                        console.log("✓ WebEngine component created successfully")
                    } catch (e) {
                        console.error("✗ Failed to create WebEngine component:", e.message)
                    }
                }
            }
        }
        
        // WebView Component
        Component {
            id: webViewComponent
                        WebView {
                            anchors.fill: parent
                            
                            onLoadingChanged: function(loadRequest) {
                                console.log("WebView loading changed - Status:", loadRequest.status, "URL:", loadRequest.url)
                                if (loadRequest.errorString) {
                                    console.error("WebView load error:", loadRequest.errorString)
                                }
                            }
                            
                            onUrlChanged: {
                                console.log("WebView URL changed to:", url)
                            }
                            
                            onLoadProgressChanged: {
                                console.log("WebView load progress:", loadProgress + "%")
                            }
                            
                            onTitleChanged: {
                                console.log("WebView title changed:", title)
                            }
                
                Component.onCompleted: {
                        console.log("✓ WebView component created successfully")
                }
            }
        }
        
        // Fallback Component (when no web backend is available)
        Component {
            id: fallbackComponent
            Rectangle {
                color: "#f0f0f0"
                border.color: "#cccccc"
                border.width: 1
                
                Column {
                    anchors.centerIn: parent
                    spacing: 20
                    
                    Text {
                        text: "❌ Web Browser Not Available"
                        font.pixelSize: 24
                        font.bold: true
                        color: "#cc0000"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    
                    Text {
                        text: "No web rendering backend found.\nInstall Qt WebEngine for desktop or Qt WebView for mobile."
                        font.pixelSize: 16
                        color: "#666666"
                        horizontalAlignment: Text.AlignHCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    
                    Text {
                        text: "Platform: " + Qt.platform.os + "\nBackend attempted: " + webBackend
                        font.pixelSize: 12
                        color: "#999999"
                        horizontalAlignment: Text.AlignHCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }
        }
    }
    
    // Keyboard shortcuts
    Shortcut {
        sequence: "Ctrl+L"
        onActivated: {
            addressBar.selectAll()
            addressBar.focus = true
        }
    }
    
    Shortcut {
        sequence: "Ctrl+R"
        onActivated: reload()
    }
    
    Shortcut {
        sequence: "F5"
        onActivated: reload()
    }
    
    Shortcut {
        sequence: "Escape"
        onActivated: {
            if (root.isLoading) {
                stop()
            }
        }
    }
    
    Shortcut {
        sequence: "Alt+Left"
        onActivated: goBack()
    }
    
    Shortcut {
        sequence: "Alt+Right"
        onActivated: goForward()
    }
    
    Shortcut {
        sequence: "Ctrl+W"
        onActivated: root.close()
    }
    
    // Initialize web backend detection when dialog opens
    Component.onCompleted: {
        console.log("=== Web Browser Dialog Opened ===")
        
        // Initialize WebView for mobile platforms
        if (Qt.platform.os === "android" || Qt.platform.os === "ios") {
            console.log("Initializing WebView for mobile platform...")
            try {
                // WebView initialization is handled automatically by Qt6.9
                console.log("✓ WebView will be initialized when component is created")
            } catch (e) {
                console.error("✗ Failed to initialize WebView:", e.message)
            }
        }
        
        detectWebBackends()
    }
} 