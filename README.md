# Voice AI LLM Assistant

A modern, cross-platform Qt6 application that provides voice-to-text capabilities, integrates with various Large Language Model (LLM) providers, and includes comprehensive device discovery and communication testing tools.

## Features

### 🎤 Voice Recognition
- Built-in voice-to-text functionality using Qt6 Multimedia
- Real-time audio level visualization
- Press-and-hold or click-to-toggle recording modes
- Audio timeout settings

### 🤖 Multiple LLM Providers
- **OpenAI**: Direct integration with OpenAI API
- **LM Studio**: Local LLM server support
- **Ollama**: Local open-source LLM support
- Easy provider switching with automatic URL configuration

### 💬 Advanced Chat Interface
- Modern, scalable UI design (1280x800 base resolution)
- Full high-DPI and scaling support for all resolutions
- Message editing and deletion
- Response regeneration
- Chat export/import functionality
- Auto-scrolling with manual override

### 📝 Custom AI Prompts
- Built-in prompt management system
- Categorized prompts (General, Programming, Creative, etc.)
- Custom prompt creation and editing
- JSON-based prompt database
- Import/export prompt collections

### 🔧 Device Discovery & Communication Testing
- **Cross-platform device discovery**: Automatic detection of network interfaces and serial ports
- **Network Device Management**: 
  - Real-time network interface discovery with connection status
  - IP address, subnet, gateway, and port configuration
  - Selectable network adapters with auto-configuration
  - Network configuration save functionality
- **Serial/COM Port Management**:
  - Automatic serial port detection and enumeration
  - Configurable baud rates (1200-921600), data bits, parity, and stop bits
  - Device-specific configuration presets (Arduino, ESP32, etc.)
  - Real-time serial communication testing
- **Advanced Ping Functionality**:
  - Cross-platform ICMP ping implementation using QPing
  - Real-time response time measurement
  - Comprehensive connectivity testing
- **Interactive Communication Test Dialog**:
  - Dual-column layout for network and serial devices
  - Real-time device status monitoring
  - Activity logging with timestamps
  - Device selection with automatic configuration loading

### 🌐 Web Browser Integration
- **Integrated web browser** with WebView/WebEngine backend
- **Adaptive backend selection**: Uses QtWebView on mobile, QtWebEngine on desktop
- **Graceful fallback**: Continues working even if web components are unavailable
- Full navigation controls (back, forward, reload, home)
- Address bar with URL validation and keyboard shortcuts
- Progress indicators and loading status

### 📊 Data Visualization & Analysis
- **Interactive Charts**: Real-time data visualization with Qt Charts
- **CSV Data Viewer**: Import, filter, and analyze CSV files
- **Raw Data Display**: Tabular data viewing with sorting and filtering
- **Series Control**: Manage multiple data series in charts
- **Export Capabilities**: Export charts and processed data

### 📄 PDF Generation & Viewing
- **QML-based PDF generation**: Template-driven PDF creation
- **PDF Viewer**: Built-in PDF viewing capabilities
- **Template System**: Customizable PDF templates
- **No WebEngine dependency**: Uses pure Qt components for PDF functionality

### 🔒 Secure Storage (Optional)
- **Qt Keychain integration** when available
- **Cross-platform secure storage** for API keys and sensitive data
- **Automatic fallback** to application settings when keychain unavailable
- **Enhanced security** on platforms with native keychain support

### ⚙️ Comprehensive Settings
- Provider-specific configuration
- API key management (with secure storage when available)
- Voice recognition settings
- UI customization options
- Theme and font size controls

### 🔄 Cross-Platform Support
- **Windows** (Full support)
- **Linux** (Full support)
- **Android** (Mobile-optimized)
- **iOS** (Mobile-optimized)
- **HarmonyOS** (Basic detection - Linux-based)

## Requirements

- **Qt 6.9 or later** (Required)
- **C++17 compatible compiler** (Required)
- **CMake 3.16+** (Required - Only supported build system)

### Qt Modules Required
- Qt6::Core
- Qt6::Gui
- Qt6::Qml
- Qt6::Quick
- Qt6::QuickControls2
- Qt6::Network
- Qt6::NetworkAuth
- Qt6::SerialPort (Required for device communication)
- Qt6::Multimedia
- Qt6::TextToSpeech
- Qt6::Concurrent
- Qt6::Pdf
- Qt6::WebChannel
- Qt6::WebSockets
- Qt6::PrintSupport
- Qt6::Svg
- Qt6::Charts

### Optional Qt Modules (Enhanced Features)
- **Qt6::WebView** - For mobile web browser functionality
- **Qt6::WebEngine + Qt6::WebEngineQuick** - For desktop web browser functionality
- **Qt6Keychain** - For secure API key storage

## Building

### ⚠️ Important: CMake Only
**This project uses CMake as the ONLY supported build system.** QMake support has been removed.

### Quick Start (Windows)
```cmd
# Use the provided build script (calls CMake internally)
build.bat

# Run the application
run.bat
```

### Manual Build (All Platforms)
```bash
# Create build directory
mkdir build && cd build

# Configure with CMake
cmake .. -DCMAKE_PREFIX_PATH=/path/to/qt6

# Build (parallel compilation enabled)
cmake --build . --parallel
```

### Prerequisites
1. **Install Qt 6.9+** with required modules (including Qt6::SerialPort)
2. **CMake 3.16+** installed and in PATH
3. **C++17 compatible compiler**
4. Platform-specific toolchain (see below)

### Platform-Specific Build Instructions

#### Windows (MSYS2/MinGW64 UCRT64)
```bash
# Ensure proper MSYS2 UCRT64 environment
export PATH="/d/msys64/ucrt64/bin:$PATH"

# Build with MinGW Makefiles
mkdir build && cd build
cmake .. -G "MinGW Makefiles" -DCMAKE_PREFIX_PATH=D:/msys64/ucrt64
mingw32-make -j$(nproc)
```

#### Linux
```bash
# Install Qt6 development packages
sudo apt install qt6-base-dev qt6-declarative-dev qt6-controls2-dev \
                 qt6-multimedia-dev qt6-charts-dev qt6-svg-dev \
                 qt6-serialport-dev

# Optional: Install web components for browser functionality
sudo apt install qt6-webengine-dev qt6-webview-dev

# Optional: Install keychain for secure storage
sudo apt install libqt6keychain1-dev

# Build
mkdir build && cd build
cmake .. -DCMAKE_PREFIX_PATH=/usr/lib/qt6
make -j$(nproc)
```

#### Android
```bash
# Requires Android SDK, NDK, and Qt for Android
mkdir build && cd build
cmake .. -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK/build/cmake/android.toolchain.cmake \
         -DANDROID_ABI=arm64-v8a \
         -DCMAKE_PREFIX_PATH=/path/to/qt6/android_arm64_v8a
make -j$(nproc)
```

#### iOS
```bash
# Requires Xcode and Qt for iOS
mkdir build && cd build
cmake .. -DCMAKE_TOOLCHAIN_FILE=/path/to/qt6/ios/lib/cmake/Qt6/qt.toolchain.cmake \
         -DCMAKE_PREFIX_PATH=/path/to/qt6/ios
make -j$(nproc)
```

#### HarmonyOS
**Note**: HarmonyOS support is currently limited to basic platform detection. Full HarmonyOS development requires:
1. HarmonyOS SDK installed
2. DevEco Studio configured
3. Qt6 compiled for HarmonyOS (if available)

*HarmonyOS support is experimental and not fully implemented yet.*

### Optional Features Configuration

The build system automatically detects and configures optional features:

#### Web Browser Support
- **✓ Available**: When Qt WebView (mobile) or Qt WebEngine (desktop) is installed
- **⚠ Limited**: When only one backend is available
- **✗ Unavailable**: When neither backend is installed
- Application continues to work without web browser functionality

#### Secure Storage Support
- **✓ Available**: When Qt Keychain is installed and detected
- **✗ Unavailable**: Falls back to application settings storage
- API keys and sensitive data stored in plain text when keychain unavailable

#### Platform Detection
Build system automatically detects and optimizes for:
- Architecture (32-bit/64-bit)
- Platform-specific features
- Available Qt modules
- Optional dependencies

## Usage

### Device Discovery & Communication Testing

1. **Launch Communication Test Dialog**:
   - Click the "📡" (Communication Test) button in the main interface
   - The dialog opens with automatic device discovery

2. **Network Device Management**:
   - View discovered network interfaces in the left panel
   - Select a network device to auto-populate configuration fields
   - Modify IP address, subnet, gateway, and port settings
   - Click "Save Network Configuration" to apply changes
   - Use the "Ping" button to test connectivity

3. **Serial/COM Port Management**:
   - View available serial ports in the right panel
   - Select a serial device to load appropriate configuration
   - Configure baud rate, data bits, parity, and stop bits
   - Connect to devices for real-time communication testing

4. **Real-time Monitoring**:
   - Activity log shows all operations with timestamps
   - Device status updates automatically
   - Connection indicators show current device states

### Initial Setup
1. Launch the application
2. Open Settings (⚙️ icon)
3. Configure your preferred LLM provider:
   - **OpenAI**: Add your API key
   - **LM Studio**: Ensure local server is running (default: localhost:1234)
   - **Ollama**: Ensure Ollama is running (default: localhost:11434)
4. Test the connection

### Voice Input
- Click the microphone button to start/stop recording
- Press and hold for continuous recording (releases when button is released)
- Audio level is visualized in real-time
- Recognized text appears in the input field and is automatically sent

### Web Browser
- Click the "B" button next to the PDF button to open the integrated browser
- Navigate using standard browser controls
- Keyboard shortcuts: Ctrl+L (address bar), F5 (reload), Alt+arrows (navigation)
- Automatically uses the best available web backend for your platform

### Data Visualization
- Import CSV files through the CSV viewer
- Create interactive charts from your data
- Filter and analyze data with built-in tools
- Export processed data and visualizations

### PDF Generation
- Generate PDFs using QML-based templates
- Customize PDF content and formatting
- View generated PDFs in the integrated viewer
- No external dependencies required

### Custom Prompts
- Select from built-in prompts via the dropdown
- Create custom prompts for specific use cases
- Organize prompts by category
- Export/import prompt collections

### Chat Management
- Edit messages by right-clicking and selecting "Edit"
- Delete unwanted messages
- Regenerate AI responses
- Export entire conversations
- Clear chat history

## Architecture

### Component Structure
```
VTT/
├── main.cpp               # Application entry point + QtWebView::initialize()
├── src/                    # C++ source files
│   ├── VoiceRecognitionManager.cpp    # Voice-to-text handling
│   ├── PlatformSpeechRecognition.cpp  # Platform-specific speech recognition
│   ├── LLMConnectionManager.cpp       # LLM provider connections
│   ├── ChatManager.cpp               # Chat conversation management
│   ├── DatabaseManager.cpp           # JSON database handling
│   ├── PromptManager.cpp             # AI prompt management
│   ├── DeviceDiscoveryManager.cpp    # Device discovery and communication
│   ├── QPing.cpp                     # Cross-platform ping implementation
│   ├── # TTSManager.cpp removed - now using Qt's native TextToSpeech
│   ├── OAuth2Manager.cpp             # OAuth2 authentication
│   ├── SecureStorageManager.cpp      # Secure credential storage
│   ├── LoggingManager.cpp            # Application logging
│   ├── QRCodeGenerator.cpp           # QR code generation
│   ├── PDFManager.cpp                # PDF management
│   ├── PDFGenerator.cpp              # PDF generation engine
│   ├── QMLPDFGenerator.cpp           # QML-based PDF generation
│   ├── PDFViewer.cpp                 # PDF viewing functionality
│   ├── CSVViewer.cpp                 # CSV data processing
│   └── SvgHandler.cpp                # SVG processing and handling
├── include/               # Header files
│   ├── PlatformDetection.h           # Cross-platform detection
│   ├── VoiceRecognitionManager.h     # Voice recognition interface
│   ├── LLMConnectionManager.h        # LLM connection interface
│   ├── ChatManager.h                 # Chat management interface
│   ├── DatabaseManager.h             # Database interface
│   ├── PromptManager.h               # Prompt management interface
│   ├── DeviceDiscoveryManager.h      # Device discovery interface
│   ├── QPing.h                       # Ping functionality interface
│   ├── # TTSManager.h removed - now using Qt's native TextToSpeech
│   ├── OAuth2Manager.h               # OAuth2 interface
│   ├── SecureStorageManager.h        # Secure storage interface
│   ├── LoggingManager.h              # Logging interface
│   ├── QRCodeGenerator.h             # QR code interface
│   ├── PDFManager.h                  # PDF management interface
│   ├── PDFGenerator.h                # PDF generation interface
│   ├── QMLPDFGenerator.h             # QML PDF generation interface
│   ├── PDFViewer.h                   # PDF viewer interface
│   ├── CSVViewer.h                   # CSV viewer interface
│   └── SvgHandler.h                  # SVG handler interface
├── qml/                  # QML UI files
│   ├── Main.qml          # Main application window
│   ├── ChatWindow.qml    # Chat interface
│   ├── MessageDelegate.qml  # Individual message display
│   ├── VoiceButton.qml   # Voice input button
│   ├── SettingsDialog.qml   # Settings configuration
│   ├── PromptManagerDialog.qml  # Prompt management
│   ├── CommTestDialog.qml    # Device communication testing
│   ├── OAuth2LoginDialog.qml # OAuth2 authentication dialog
│   ├── WebBrowser.qml    # Integrated web browser
│   ├── PDFDialog.qml     # PDF generation & viewing
│   ├── PDFViewer.qml     # PDF viewer component
│   ├── CSVDialog.qml     # CSV data viewer dialog
│   ├── CSVViewer.qml     # CSV viewer component
│   ├── CSVViewerComponent.qml # CSV viewer sub-component
│   ├── InteractiveChart.qml  # Data visualization
│   ├── DataSeriesControl.qml # Chart series control
│   ├── SeriesControl.qml     # Series management
│   ├── SeriesDelegate.qml    # Series display delegate
│   ├── DataFilterControl.qml # Data filtering controls
│   ├── RawDataViewer.qml     # Raw data display
│   ├── QmlViewerDialog.qml   # QML code viewer
│   ├── SvgViewerDialog.qml   # SVG viewer dialog
│   ├── SvgHandler.qml        # SVG handler component
│   └── pdf_templates/        # PDF template directory
│       └── diagnostic_template.qml  # Diagnostic PDF template
├── data/                 # Database and resources
│   └── voiceaillm.db     # JSON database file
├── resources/            # Icons and assets
│   ├── icons/            # Application icons
│   ├── templates/        # Document templates
│   └── ...               # Other resources
├── build/                # Build output directory (generated)
└── CMakeLists.txt        # CMake build configuration (ONLY build system)
```

### Key Classes

#### DeviceDiscoveryManager
- Cross-platform device detection and management
- QAbstractListModel for QML integration
- Real-time device status monitoring
- Network interface and serial port discovery

#### QPing
- Custom ICMP ping implementation
- Cross-platform network connectivity testing
- Real-time response time measurement
- Process-based ping execution

#### VoiceRecognitionManager
- Handles audio input and voice recognition
- Provides real-time audio level monitoring
- Cross-platform audio device management
- Platform-specific speech recognition integration

#### LLMConnectionManager
- Manages connections to different LLM providers
- Handles API requests and responses
- Provider-specific request formatting

#### ChatManager
- QAbstractListModel for chat messages
- Message CRUD operations
- Chat persistence and export

#### DatabaseManager
- JSON-based data storage
- Prompt and settings management
- Backup and restore functionality

#### PromptManager
- QAbstractListModel for AI prompts
- Category-based organization
- Import/export capabilities

#### TTS Component (Qt Native TextToSpeech)
- Text-to-speech functionality
- Cross-platform TTS engine support
- Voice selection and configuration

#### OAuth2Manager
- OAuth2 authentication handling
- Secure token management
- Provider-specific OAuth flows

#### SecureStorageManager
- Cross-platform secure credential storage
- Qt Keychain integration
- Fallback to encrypted settings

#### PDFManager & PDFGenerator
- PDF document generation and management
- QML-based template system
- PDF viewing and export capabilities

#### CSVViewer
- CSV data import and processing
- Interactive data visualization
- Chart generation and export

#### SvgHandler
- SVG file processing and rendering
- SVG viewer integration
- Vector graphics manipulation

#### QRCodeGenerator
- QR code generation functionality
- Customizable QR code parameters
- Integration with application data

#### LoggingManager
- Application-wide logging system
- Multiple log levels and outputs
- Debug and production logging modes

### Scaling and Responsiveness
The UI uses a sophisticated scaling system:
- Base resolution: 1280x800
- Dynamic scale factor: `Math.min(width/1280, height/800)`
- All elements scale proportionally
- Font sizes and spacing adjust automatically
- Minimum window size: 800x600

## Database Schema

The application uses a JSON-based database stored in plaintext:

```json
{
  "version": "1.0",
  "prompts": [
    {
      "id": "unique-id",
      "name": "Display Name",
      "content": "System prompt content",
      "category": "Category Name",
      "isActive": false,
      "createdAt": "ISO date string",
      "modifiedAt": "ISO date string"
    }
  ],
  "settings": {
    "theme": "light",
    "fontSize": 14,
    "autoSave": true,
    "streamingMode": true,
    "maxTokens": 2048,
    "temperature": 0.7
  },
  "chatHistory": []
}
```

## Troubleshooting

### Common Build Issues

1. **Qt6::SerialPort not found**:
   ```bash
   # Install Qt6 SerialPort module
   # Linux: sudo apt install qt6-serialport-dev
   # Windows: Ensure Qt installation includes SerialPort
   ```

2. **Device discovery not working**:
   - Ensure Qt6::SerialPort is installed and linked
   - Check platform permissions for device access
   - Verify network interface permissions

3. **Ping functionality issues**:
   - QPing uses system ping command
   - Ensure ping is available in system PATH
   - Check network permissions and firewall settings

4. **CMake configuration errors**:
   ```bash
   # Clear build directory and reconfigure
   rm -rf build
   mkdir build && cd build
   cmake .. -DCMAKE_PREFIX_PATH=/path/to/qt6
   ```

### Platform-Specific Issues

- **Windows**: Ensure MSYS2 UCRT64 environment is properly configured
- **Linux**: Install all required Qt6 development packages
- **Android**: Requires Qt for Android and proper SDK/NDK setup
- **iOS**: Requires Xcode and Qt for iOS installation

## Extending the Application

### Adding New LLM Providers
1. Add enum value in `LLMConnectionManager::Provider`
2. Implement request method (e.g., `sendNewProviderRequest`)
3. Add URL mapping in `setCurrentProvider`
4. Update UI dropdown in `SettingsDialog.qml`

### Adding Device Communication Features
1. Extend `DeviceDiscoveryManager` with new device types
2. Add device-specific configuration in QML
3. Implement communication protocols in C++
4. Update UI to display new device information

### Adding New Voice Recognition Engines
1. Implement platform-specific methods in `src/PlatformSpeechRecognition.cpp`
2. Add library detection and linking in `CMakeLists.txt`
3. Update initialization code in `VoiceRecognitionManager::initializePlatformSpeechRecognition()`
4. Test hybrid local/cloud recognition functionality
5. Update platform detection in `include/PlatformDetection.h`

### Custom Themes
1. Modify color properties in `Main.qml`
2. Add theme selection in `SettingsDialog.qml`
3. Persist theme choice in database settings

## Platform-Specific Voice Recognition

### Current Implementation Status

The application now provides **COMPLETE** platform-specific voice recognition implementations with Google Cloud Speech API fallback:

#### Windows ✅ **IMPLEMENTED**
- **Windows Speech API (SAPI)** with COM integration
- Real-time speech recognition with optimized performance
- Automatic fallback to Google Cloud Speech API if SAPI fails
- Memory management and threading optimizations

#### Android 🚧 **FRAMEWORK READY**
- Android Speech Recognition API framework implemented
- JNI bindings structure in place
- Requires JNI implementation completion for production use
- Falls back to Google Cloud Speech API

#### iOS 🚧 **FRAMEWORK READY**
- iOS Speech Framework integration structure implemented
- Objective-C++ interface framework in place
- Requires Speech Framework completion for production use
- Falls back to Google Cloud Speech API

#### Linux 🚧 **FRAMEWORK READY**
- PocketSphinx/Vosk integration framework implemented
- Runtime library detection for speech engines
- Falls back to Google Cloud Speech API when libraries unavailable

### Performance Optimizations ⚡

#### Real-Time Audio Processing
- **Dedicated Audio Thread**: Separate high-priority thread for audio processing prevents UI blocking
- **Optimized Buffer Management**: Efficient audio buffer handling with memory pooling
- **Configurable Sample Rates**: 16kHz optimized for speech recognition
- **Low-Latency Processing**: Minimized delay between speech and recognition

#### Memory Management
- **Automatic Memory Cleanup**: Smart pointers and RAII for audio resources
- **Buffer Size Optimization**: Dynamic buffer sizing based on available memory
- **Audio Level Monitoring**: Real-time level calculation without excessive memory allocation
- **Platform-Specific Optimizations**: Native memory management for each platform

#### Threading Architecture
- **UI Thread Separation**: Audio processing never blocks user interface
- **Worker Thread Pool**: Dedicated threads for different audio operations
- **Thread-Safe Communication**: Proper synchronization between audio and UI threads
- **Priority Management**: High-priority audio threads for real-time performance

### Build System Features 🛠️

CMake configuration includes:
- **Automatic Parallel Compilation**: Detects CPU cores and optimizes build speed
- **Platform-Specific Optimizations**: Windows/Linux/Android/iOS/HarmonyOS detection
- **Optional Feature Detection**: Automatically detects and configures WebView/WebEngine/Keychain
- **Qt6 Integration**: Modern CMake-based Qt6 module linking
- **Cross-Compilation Support**: Android and iOS toolchain integration

### Speech Recognition Accuracy & Performance

#### Local Recognition (When Available)
- **Windows SAPI**: Native Windows speech recognition with system voice models
- **Real-Time Processing**: < 500ms latency for speech-to-text conversion
- **Offline Capability**: No internet required for basic speech recognition

#### Cloud Fallback
- **Google Cloud Speech API**: High-accuracy cloud-based recognition
- **Automatic Switching**: Seamless fallback when local recognition unavailable
- **Network Optimization**: Efficient audio data compression and transmission

#### Hybrid Approach Benefits
- **Best of Both Worlds**: Local speed + Cloud accuracy
- **Reliability**: Always functional regardless of platform capabilities
- **Scalability**: Easy to add new speech engines without breaking existing functionality

## Security Considerations

### API Key Storage
- **Secure Storage**: Uses Qt Keychain when available for encrypted API key storage
- **Fallback Storage**: Falls back to application settings when keychain unavailable
- **Platform Native**: Integrates with Windows Credential Manager, macOS Keychain, Linux Secret Service
- **Automatic Detection**: Build system automatically detects and configures keychain support

### Privacy & Data Protection
- **Local Voice Processing**: Voice data processed locally when possible
- **Secure Communications**: All network communications use HTTPS/TLS
- **Local Database**: User data stored locally in JSON format
- **No Telemetry**: Application does not collect or transmit usage data

### Web Browser Security
- **Sandboxed Browsing**: Web components run in isolated environment
- **Platform Security**: Inherits security model from QtWebView/QtWebEngine
- **Local Resources**: No external resource loading without user consent

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test on multiple platforms
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Troubleshooting

### Common Issues

1. **Build Errors**: 
   - Ensure Qt 6.9+ is installed with all required modules
   - Verify CMake 3.16+ is available and in PATH
   - Check that Qt path is correctly set in CMAKE_PREFIX_PATH

2. **Voice Not Working**: 
   - Check microphone permissions and audio device availability
   - Verify Qt Multimedia module is properly installed

3. **LLM Connection Failed**: 
   - Verify API keys and network connectivity
   - Check if Qt Keychain is working for secure storage
   - Try regenerating API keys if stored securely

4. **Web Browser Not Available**:
   - Install Qt WebEngine (desktop) or Qt WebView (mobile)
   - Application will show fallback message if web components unavailable
   - Browser button will be disabled if no web backend available

5. **High DPI Issues**: 
   - Enable Qt high DPI scaling in your environment
   - Check scaling factor calculation in Main.qml

### Platform-Specific Issues

#### Windows (MSYS2 UCRT64)
- Ensure proper MSYS2 UCRT64 environment (not MinGW64)
- Check Visual C++ Redistributable installation
- Verify Windows Defender firewall settings
- Use `build.bat` script for proper environment setup

#### Linux
- Install required packages: `sudo apt install qt6-base-dev qt6-declarative-dev`
- For web browser: `sudo apt install qt6-webengine-dev qt6-webview-dev`  
- For secure storage: `sudo apt install libqt6keychain1-dev`
- Check PulseAudio/ALSA configuration for audio

#### Android/iOS
- Ensure appropriate permissions for microphone access in manifest
- Test on physical device rather than emulator for voice features
- Qt WebView should be available on mobile platforms

#### HarmonyOS
- **Limited Support**: Only basic platform detection implemented
- Requires HarmonyOS SDK and Qt6 compiled for HarmonyOS
- Most features will fallback to Linux-compatible implementations

### Feature Availability Check

The application logs feature availability at startup:
- Look for "✓" (available) or "✗" (unavailable) messages in console
- Web browser status shows backend availability
- Keychain availability affects secure storage functionality 