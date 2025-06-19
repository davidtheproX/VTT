import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts
import QtWebView

Dialog {
    id: root
    title: webView.title || "Web Browser"
    width: 1200
    height: 800
    modal: true
    standardButtons: Dialog.Close
    
    property string currentUrl: ""
    property real scaleFactor: 1.0
    property color primaryColor: "#2196F3"
    property color backgroundColor: "#f5f5f5"
    property color textColor: "#333333"
    
    // Navigation state (bound directly to the WebView)
    property bool canGoBack: webView.canGoBack
    property bool canGoForward: webView.canGoForward
    property bool isLoading: webView.loading
    property int loadProgress: webView.loadProgress
    
    function navigateToUrl(url) {
        if (url && url.length > 0) {
            if (!url.startsWith("http://") && !url.startsWith("https://")) {
                url = "https://" + url
            }
            console.log("Navigating to:", url)
            currentUrl = url
            webView.url = url
        }
    }
    
    function goBack() {
        if (webView.canGoBack) {
            webView.goBack()
        }
    }
    
    function goForward() {
        if (webView.canGoForward) {
            webView.goForward()
        }
    }
    
    function reload() {
        if (webView.reload) {
            webView.reload()
        }
    }
    
    function stop() {
        if (webView.stop) {
            webView.stop()
        }
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
                    font.pixelSize: 16 * scaleFactor
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                
                ToolTip.text: root.isLoading ? "Stop Loading" : "Reload Page"
                ToolTip.visible: hovered
                
                onClicked: {
                    if (root.isLoading) {
                        stop()
                    } else {
                        reload()
                    }
                }
            }
            
            // Address bar
            TextField {
                id: addressBar
                Layout.fillWidth: true
                placeholderText: "Enter URL or search..."
                selectByMouse: true
                
                background: Rectangle {
                    color: "white"
                    border.color: addressBar.activeFocus ? primaryColor : "#cccccc"
                    border.width: 1
                    radius: 4
                }
                
                onAccepted: {
                    var url = text.trim()
                    if (url.length > 0) {
                        navigateToUrl(url)
                    }
                }
                
                Keys.onEscapePressed: {
                    text = currentUrl
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
    
    // Main content area - using ColumnLayout to prevent overlapping
    contentItem: ColumnLayout {
        anchors.fill: parent
        spacing: 0
        
        // Progress bar - positioned above the WebView to avoid overlapping
        ProgressBar {
            id: progressBar
            Layout.fillWidth: true
            Layout.preferredHeight: 2 * scaleFactor
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
        
        // The single WebView component - no complex backend detection needed
        WebView {
            id: webView
            Layout.fillWidth: true
            Layout.fillHeight: true
            
            // Initial URL
            url: "https://www.google.com"
            
            onLoadingChanged: function(loadRequest) {
                console.log("WebView loading changed - Status:", loadRequest.status, "URL:", loadRequest.url)
                if (loadRequest.errorString) {
                    console.error("WebView load error:", loadRequest.errorString)
                }
            }
            
            onUrlChanged: {
                console.log("WebView URL changed to:", url)
                currentUrl = url
                addressBar.text = currentUrl
            }
            
            onLoadProgressChanged: {
                console.log("WebView load progress:", loadProgress + "%")
            }
            
            onTitleChanged: {
                console.log("WebView title changed:", title)
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
    
    Component.onCompleted: {
        console.log("=== Web Browser Dialog Opened ===")
        console.log("Platform:", Qt.platform.os)
        console.log("WebView component loaded, QtWebView::initialize() was called in C++")
        
        // No need for complex backend detection - Qt WebView handles this automatically:
        // - Android: Uses Android System WebView
        // - iOS: Uses WKWebView  
        // - Windows: Uses Edge WebView2
        // - Linux: Uses QtWebEngine or system default
        // - macOS: Uses WKWebView
        // - HarmonyOS: Uses system default
    }
} 