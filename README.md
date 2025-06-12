# Voice AI LLM Assistant

A modern, cross-platform Qt6 application that provides voice-to-text capabilities and integrates with various Large Language Model (LLM) providers including OpenAI, LM Studio, and Ollama.

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

### ⚙️ Comprehensive Settings
- Provider-specific configuration
- API key management (with secure input)
- Voice recognition settings
- UI customization options
- Theme and font size controls

### 🔄 Cross-Platform Support
- Windows
- Linux
- iOS
- Android
- HarmonyOS

## Requirements

- Qt 6.9 or later
- C++17 compatible compiler
- qmake (included with Qt)

### Qt Modules Required
- Qt6::Core
- Qt6::Gui
- Qt6::Qml
- Qt6::Quick
- Qt6::QuickControls2
- Qt6::Network

## Building

### Quick Start (Windows)
```cmd
# Use the provided build script
build.bat

# Run the application
run.bat
```

### Manual Build
```bash
# Generate Makefile
qmake VoiceAILLM.pro

# Build the project
make
```

### Prerequisites
1. Install Qt 6.9+ with QML and QuickControls2 modules
2. Ensure MSYS2/MinGW64 is properly configured for Windows
3. C++17 compatible compiler

### Platform-Specific Notes

#### Windows (MSYS2/MinGW64)
```bash
# Ensure proper environment
export PATH="/d/msys64/mingw64/bin:$PATH"
qmake -spec win32-g++ VoiceAILLM.pro
mingw32-make
```

#### Linux
```bash
# Install Qt6 development packages
sudo apt install qt6-base-dev qt6-declarative-dev qt6-controls2-dev
qmake VoiceAILLM.pro
make -j$(nproc)
```

#### Qt Creator
- Open `VoiceAILLM.pro` in Qt Creator
- Configure with Qt 6.9+ kit
- Build and run directly from IDE

## Usage

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
├── src/                    # C++ source files
│   ├── main.cpp           # Application entry point
│   ├── VoiceRecognitionManager.cpp    # Voice-to-text handling
│   ├── LLMConnectionManager.cpp       # LLM provider connections
│   ├── ChatManager.cpp               # Chat conversation management
│   ├── DatabaseManager.cpp           # JSON database handling
│   └── PromptManager.cpp             # AI prompt management
├── include/               # Header files
├── qml/                  # QML UI files
│   ├── Main.qml          # Main application window
│   ├── ChatWindow.qml    # Chat interface
│   ├── MessageDelegate.qml  # Individual message display
│   ├── VoiceButton.qml   # Voice input button
│   └── SettingsDialog.qml   # Settings configuration
├── data/                 # Database and resources
│   └── voiceaillm.db     # JSON database file
└── resources/            # Icons and assets
```

### Key Classes

#### VoiceRecognitionManager
- Handles audio input and voice recognition
- Provides real-time audio level monitoring
- Cross-platform audio device management

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

## Extending the Application

### Adding New LLM Providers
1. Add enum value in `LLMConnectionManager::Provider`
2. Implement request method (e.g., `sendNewProviderRequest`)
3. Add URL mapping in `setCurrentProvider`
4. Update UI dropdown in `SettingsDialog.qml`

### Adding New Voice Recognition Engines
1. Extend `VoiceRecognitionManager::processVoiceToText`
2. Add platform-specific implementations
3. Update initialization code for new engines

### Custom Themes
1. Modify color properties in `Main.qml`
2. Add theme selection in `SettingsDialog.qml`
3. Persist theme choice in database settings

## Platform-Specific Voice Recognition

### Current Implementation
The current implementation provides a framework for voice recognition but includes platform-specific notes:

#### Windows
- Use Windows Speech API (SAPI)
- Integration with Windows Speech Recognition

#### Android
- Android Speech Recognition API
- Google Speech Services integration

#### iOS
- iOS Speech Framework
- SFSpeechRecognizer integration

#### Linux
- PulseAudio integration
- Optional: PocketSphinx or Vosk integration

### Implementing Additional Voice Recognition
The current implementation uses Google Speech-to-Text API. To add additional voice recognition engines:

1. Platform-specific speech recognition APIs
2. Cloud-based services (Google Speech-to-Text, Azure Speech)
3. Local libraries (Whisper, Vosk, PocketSphinx)

## Security Considerations

- API keys are stored in application settings (consider encryption for production)
- Voice data is processed locally when possible
- Network communications use HTTPS where supported
- Database file is stored in user's application data directory

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

1. **Build Errors**: Ensure Qt 6.9+ is installed with all required modules
2. **Voice Not Working**: Check microphone permissions and audio device availability
3. **LLM Connection Failed**: Verify API keys and network connectivity
4. **High DPI Issues**: Enable Qt high DPI scaling in your environment

### Platform-Specific Issues

#### Windows
- Ensure Visual C++ Redistributable is installed
- Check Windows Defender firewall settings

#### Linux
- Install required audio libraries: `sudo apt install libasound2-dev`
- Check PulseAudio configuration

#### Mobile Platforms
- Request appropriate permissions for microphone access
- Test on device rather than emulator for voice features 