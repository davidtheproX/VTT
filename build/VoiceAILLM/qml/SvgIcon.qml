import QtQuick

Item {
    id: root
    
    // Public properties
    property alias source: svgImage.source
    property alias fillMode: svgImage.fillMode
    property alias sourceSize: svgImage.sourceSize
    property alias cache: svgImage.cache
    property alias smooth: svgImage.smooth
    property alias asynchronous: svgImage.asynchronous
    property alias status: svgImage.status
    property color color: "transparent"
    property string fallbackText: ""
    property color fallbackColor: "#666666"
    
    // Ensure SVG is rendered at the right size
    implicitWidth: 24
    implicitHeight: 24
    
    Image {
        id: svgImage
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        smooth: true
        asynchronous: false // Try synchronous loading first
        cache: false // Disable cache to force fresh load
        
        // Enable SVG rendering with explicit size
        sourceSize.width: Math.max(root.width, 24)
        sourceSize.height: Math.max(root.height, 24)
        
        // Color overlay for monochrome SVGs (if needed)
        visible: status === Image.Ready && root.color === "transparent"
        
        onStatusChanged: {
            console.log("=== SVG Status Changed ===")
            console.log("Source:", source)
            console.log("Status:", status)
            console.log("Width x Height:", width + "x" + height)
            console.log("SourceSize:", sourceSize.width + "x" + sourceSize.height)
            
            if (status === Image.Error) {
                console.error("❌ Failed to load SVG:", source)
                console.error("Image status: Error")
            } else if (status === Image.Ready) {
                console.log("✅ SVG loaded successfully:", source)
                console.log("Image size:", implicitWidth + "x" + implicitHeight)
            } else if (status === Image.Loading) {
                console.log("⏳ Loading SVG:", source)
            } else if (status === Image.Null) {
                console.log("❓ SVG status is null:", source)
            }
        }
        
        onSourceChanged: {
            console.log("=== SVG Source Changed ===")
            console.log("New source:", source)
        }
    }
    
    // Colored version of SVG (if color is specified)
    Image {
        id: coloredSvg
        anchors.fill: parent
        source: svgImage.source
        fillMode: svgImage.fillMode
        sourceSize: svgImage.sourceSize
        smooth: svgImage.smooth
        asynchronous: svgImage.asynchronous
        visible: root.color !== "transparent" && svgImage.status === Image.Ready
        
        // Apply color tint for monochrome SVGs
        layer.enabled: root.color !== "transparent"
        layer.effect: Rectangle {
            color: root.color
        }
    }
    
    // Fallback text when SVG fails to load
    Text {
        anchors.centerIn: parent
        text: root.fallbackText
        color: root.fallbackColor
        font.pixelSize: Math.min(root.width, root.height) * 0.6
        font.bold: true
        visible: svgImage.status !== Image.Ready && root.fallbackText.length > 0
    }
    
    // Debug information
    Component.onCompleted: {
        console.log("SvgIcon created for source:", source)
    }
} 