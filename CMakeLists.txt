cmake_minimum_required(VERSION 3.16)
project(VoiceAILLM VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

# Enable parallel compilation for all available cores
include(ProcessorCount)
ProcessorCount(N)
if(NOT N EQUAL 0)
    message(STATUS "Detected ${N} processors - enabling parallel compilation")
    # Set parallel compilation for different build systems
    if(CMAKE_GENERATOR MATCHES "Visual Studio")
        # For Visual Studio generators
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /MP${N}")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} /MP${N}")
    elseif(CMAKE_GENERATOR MATCHES "Ninja" OR CMAKE_GENERATOR MATCHES "Unix Makefiles" OR CMAKE_GENERATOR MATCHES "MinGW Makefiles")
        # For Ninja and Make generators, set parallel job count
        set(CMAKE_BUILD_PARALLEL_LEVEL ${N} CACHE STRING "Parallel build jobs" FORCE)
        set_property(GLOBAL PROPERTY JOB_POOLS compile_pool=${N} link_pool=4)
        set_property(GLOBAL PROPERTY JOB_POOL_COMPILE compile_pool)
        set_property(GLOBAL PROPERTY JOB_POOL_LINK link_pool)
        
        # Add compiler flags for parallel template instantiation (GCC/Clang)
        if(CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
            set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -ftemplate-backtrace-limit=0")
            # Note: LTO disabled for MSYS2 UCRT64 Qt6 compatibility
        endif()
    endif()
    
    # Set environment variable for make
    set(ENV{MAKEFLAGS} "-j${N}")
else()
    message(STATUS "Could not detect processor count - using default compilation")
    set(CMAKE_BUILD_PARALLEL_LEVEL 48 CACHE STRING "Parallel build jobs" FORCE)
endif()

# Platform detection and configuration
if(WIN32)
    message(STATUS "Configuring for Windows")
    add_compile_definitions(PLATFORM_WINDOWS)
    if(MINGW)
        message(STATUS "Using MinGW compiler")
    elseif(MSVC)
        message(STATUS "Using MSVC compiler")
    endif()
elseif(ANDROID)
    message(STATUS "Configuring for Android")
    add_compile_definitions(PLATFORM_ANDROID)
    # Android-specific configurations
    set(ANDROID_STL "c++_shared")
    set(ANDROID_CPP_FEATURES "rtti exceptions")
elseif(IOS)
    message(STATUS "Configuring for iOS")
    add_compile_definitions(PLATFORM_IOS)
    # iOS-specific configurations
    set(CMAKE_OSX_DEPLOYMENT_TARGET "11.0")
    set(CMAKE_XCODE_ATTRIBUTE_DEVELOPMENT_TEAM "YOUR_TEAM_ID" CACHE STRING "Development Team ID")
elseif(CMAKE_SYSTEM_NAME STREQUAL "Linux")
    message(STATUS "Configuring for Linux")
    add_compile_definitions(PLATFORM_LINUX)
    # Check for HarmonyOS (based on Linux kernel)
    if(EXISTS "/system/bin/hdc" OR EXISTS "/system/bin/harmony")
        message(STATUS "Detected HarmonyOS environment")
        add_compile_definitions(PLATFORM_HARMONYOS)
    endif()
else()
    message(STATUS "Configuring for unknown platform: ${CMAKE_SYSTEM_NAME}")
    add_compile_definitions(PLATFORM_UNKNOWN)
endif()

# Architecture detection
if(CMAKE_SIZEOF_VOID_P EQUAL 8)
    message(STATUS "64-bit architecture detected")
    add_compile_definitions(ARCH_64BIT)
else()
    message(STATUS "32-bit architecture detected")
    add_compile_definitions(ARCH_32BIT)
endif()

# Find Qt6 components
find_package(Qt6 REQUIRED COMPONENTS 
    Core 
    Gui 
    Qml 
    Quick 
    QuickControls2 
    Network 
    NetworkAuth
    SerialPort
    Multimedia 
    TextToSpeech
    Concurrent
    Pdf
    WebChannel
    WebSockets
    PrintSupport
    Svg
    Charts
)

# Platform-specific web components
set(WEB_COMPONENTS_AVAILABLE FALSE)
set(WEB_BACKEND "None")

# Try to find WebView first (preferred on mobile platforms)
find_package(Qt6 QUIET COMPONENTS WebView)
if(TARGET Qt6::WebView)
    set(WEB_COMPONENTS_AVAILABLE TRUE)
    set(WEB_BACKEND "WebView")
    message(STATUS "✓ Qt6 WebView found - mobile-optimized web component available")
    list(APPEND QT_WEB_COMPONENTS WebView)
else()
    message(STATUS "✗ Qt6 WebView not found")
endif()

# On Windows and Linux, WebView depends on WebEngine, so try to find WebEngine
if(WIN32 OR CMAKE_SYSTEM_NAME STREQUAL "Linux")
    find_package(Qt6 QUIET COMPONENTS WebEngine WebEngineQuick)
    if(TARGET Qt6::WebEngine AND TARGET Qt6::WebEngineQuick)
        set(WEB_COMPONENTS_AVAILABLE TRUE)
        if(WEB_BACKEND STREQUAL "None")
            set(WEB_BACKEND "WebEngine")
        else()
            set(WEB_BACKEND "${WEB_BACKEND}+WebEngine")
        endif()
        message(STATUS "✓ Qt6 WebEngine found - full web browser backend available")
        list(APPEND QT_WEB_COMPONENTS WebEngine WebEngineQuick)
        add_compile_definitions(HAVE_WEBENGINE=1)
    else()
        message(WARNING "⚠ Qt6 WebEngine not found - web browser functionality will be limited on Windows/Linux")
        message(WARNING "  On Windows/Linux, Qt WebView requires WebEngine as backend")
        message(WARNING "  Install Qt WebEngine package for full web browser support")
        add_compile_definitions(HAVE_WEBENGINE=0)
    endif()
else()
    # On mobile platforms, WebView uses native APIs
    add_compile_definitions(HAVE_WEBENGINE=0)
endif()

# Final web components status
if(WEB_COMPONENTS_AVAILABLE)
    message(STATUS "🌐 Web Browser Status: AVAILABLE (Backend: ${WEB_BACKEND})")
    add_compile_definitions(HAVE_WEB_BROWSER=1)
    if(QT_WEB_COMPONENTS)
        list(APPEND CMAKE_FIND_ROOT_PATH ${Qt6_DIR})
        foreach(component ${QT_WEB_COMPONENTS})
            find_package(Qt6 REQUIRED COMPONENTS ${component})
        endforeach()
    endif()
else()
    message(WARNING "🌐 Web Browser Status: NOT AVAILABLE")
    message(WARNING "  Install Qt WebView (mobile) or Qt WebEngine (desktop) for web browser functionality")
    add_compile_definitions(HAVE_WEB_BROWSER=0)
endif()

# Platform-specific Qt components
if(ANDROID)
    find_package(Qt6 QUIET COMPONENTS AndroidExtras)
    if(TARGET Qt6::AndroidExtras)
        message(STATUS "Qt6 AndroidExtras found")
        list(APPEND QT_REQUIRED_COMPONENTS AndroidExtras)
    endif()
endif()

# Find optional Qt6 TextToSpeech component if available
find_package(Qt6 QUIET COMPONENTS TextToSpeech)

# Enhanced Qt Keychain detection for secure storage across all platforms
message(STATUS "Searching for Qt Keychain...")

# Method 1: Try to find via pkg-config (preferred on Linux)
find_package(PkgConfig QUIET)
if(PkgConfig_FOUND)
    pkg_check_modules(QTKEYCHAIN QUIET qt6keychain)
    if(QTKEYCHAIN_FOUND)
        message(STATUS "Qt Keychain found via pkg-config")
        set(QTKEYCHAIN_METHOD "pkg-config")
    endif()
endif()

# Method 2: Try CMake's find_package
if(NOT QTKEYCHAIN_FOUND)
    find_package(Qt6Keychain QUIET)
    if(Qt6Keychain_FOUND)
        set(QTKEYCHAIN_FOUND TRUE)
        set(QTKEYCHAIN_LIBRARIES Qt6::Keychain)
        message(STATUS "Qt Keychain found via CMake find_package")
        set(QTKEYCHAIN_METHOD "cmake")
    endif()
endif()

# Method 3: Manual search with platform-specific paths
if(NOT QTKEYCHAIN_FOUND)
    message(STATUS "Performing manual Qt Keychain search...")
    set(QTKEYCHAIN_SEARCH_PATHS)
    set(QTKEYCHAIN_INCLUDE_SEARCH_PATHS)
    
    if(WIN32)
        message(STATUS "Searching Windows-specific paths for Qt Keychain...")
        list(APPEND QTKEYCHAIN_SEARCH_PATHS 
            "D:/msys64/ucrt64/lib"
            "C:/Qt/Tools/QtCreator/lib/qtkeychain"
            "${CMAKE_PREFIX_PATH}/lib"
            "C:/vcpkg/installed/x64-windows/lib"
            "C:/vcpkg/installed/x86-windows/lib"
        )
        set(QTKEYCHAIN_INCLUDE_SEARCH_PATHS
            "D:/msys64/ucrt64/include"
            "C:/Qt/Tools/QtCreator/include"
            "${CMAKE_PREFIX_PATH}/include"
            "C:/vcpkg/installed/x64-windows/include"
            "C:/vcpkg/installed/x86-windows/include"
        )
        set(QTKEYCHAIN_LIB_NAMES qt6keychain qtkeychain-qt6 qt5keychain keychain)
    elseif(APPLE)
        message(STATUS "Searching macOS-specific paths for Qt Keychain...")
        list(APPEND QTKEYCHAIN_SEARCH_PATHS 
            "/usr/local/lib"
            "/opt/homebrew/lib"
            "/usr/lib"
            "/opt/local/lib"  # MacPorts
        )
        set(QTKEYCHAIN_INCLUDE_SEARCH_PATHS
            "/usr/local/include"
            "/opt/homebrew/include"
            "/usr/include"
            "/opt/local/include"  # MacPorts
        )
        set(QTKEYCHAIN_LIB_NAMES qt6keychain qtkeychain-qt6 qt5keychain keychain)
    elseif(UNIX)  # Linux, Android, HarmonyOS
        message(STATUS "Searching Unix/Linux-specific paths for Qt Keychain...")
        list(APPEND QTKEYCHAIN_SEARCH_PATHS 
            "/usr/lib"
            "/usr/local/lib"
            "/usr/lib/x86_64-linux-gnu"
            "/usr/lib/aarch64-linux-gnu"
            "/usr/lib64"
            "/lib64"
            "/lib"
        )
        set(QTKEYCHAIN_INCLUDE_SEARCH_PATHS
            "/usr/include"
            "/usr/local/include"
        )
        set(QTKEYCHAIN_LIB_NAMES qt6keychain qtkeychain-qt6 qt5keychain keychain libqtkeychain)
    endif()
    
    find_library(QTKEYCHAIN_LIBRARIES
        NAMES ${QTKEYCHAIN_LIB_NAMES}
        PATHS ${QTKEYCHAIN_SEARCH_PATHS}
        PATH_SUFFIXES lib lib64
    )
    find_path(QTKEYCHAIN_INCLUDE_DIRS
        NAMES qt6keychain/keychain.h qtkeychain/keychain.h keychain.h
        PATHS ${QTKEYCHAIN_INCLUDE_SEARCH_PATHS}
        PATH_SUFFIXES include
    )
    
    if(QTKEYCHAIN_LIBRARIES AND QTKEYCHAIN_INCLUDE_DIRS)
        set(QTKEYCHAIN_FOUND TRUE)
        message(STATUS "Qt Keychain found via manual search")
        message(STATUS "  Library: ${QTKEYCHAIN_LIBRARIES}")
        message(STATUS "  Include: ${QTKEYCHAIN_INCLUDE_DIRS}")
        set(QTKEYCHAIN_METHOD "manual")
    endif()
endif()

# Final status report - Force disable Qt Keychain for Qt6.9 UCRT64 compatibility
message(STATUS "✗ Qt Keychain disabled for Qt6.9 UCRT64 compatibility - using fallback encryption")
add_compile_definitions(HAVE_QTKEYCHAIN=0)

# Set Qt6.9 specific policies to suppress warnings and ensure compatibility
qt_policy(SET QTP0001 NEW)  # Use new resource prefix for QML modules
qt_policy(SET QTP0004 NEW)  # Allow qmldir files for extra directories

qt_standard_project_setup()

# Source files
set(SOURCES 
    main.cpp
    src/VoiceRecognitionManager.cpp
    src/PlatformSpeechRecognition.cpp
    src/LLMConnectionManager.cpp
    src/ChatManager.cpp
    src/DatabaseManager.cpp
    src/PromptManager.cpp
    src/TTSManager.cpp
    src/SecureStorageManager.cpp
    src/LoggingManager.cpp
    src/OAuth2Manager.cpp
    src/QRCodeGenerator.cpp
    src/PDFManager.cpp
    src/PDFGenerator.cpp
    src/QMLPDFGenerator.cpp
    src/PDFViewer.cpp
    src/CSVViewer.cpp
    src/SvgHandler.cpp
    src/DeviceDiscoveryManager.cpp
    src/QPing.cpp
)

# Header files
set(HEADERS
    include/PlatformDetection.h
    include/ChatManager.h
    include/VoiceRecognitionManager.h
    include/LLMConnectionManager.h
    include/DatabaseManager.h
    include/PromptManager.h
    include/TTSManager.h
    include/SecureStorageManager.h
    include/LoggingManager.h
    include/OAuth2Manager.h
    include/QRCodeGenerator.h
    include/PDFManager.h
    include/PDFGenerator.h
    include/QMLPDFGenerator.h
    include/PDFViewer.h
    include/CSVViewer.h
    include/SvgHandler.h
    include/DeviceDiscoveryManager.h
    include/QPing.h
    # Android-specific headers
    include/AndroidPermissionManager.h
    include/AndroidKeystoreManager.h
)

# Create the executable with platform-specific properties
if(ANDROID)
    qt_add_executable(VoiceAILLM ${SOURCES} ${HEADERS})
    set_target_properties(VoiceAILLM PROPERTIES
        QT_ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android"
    )
elseif(IOS)
    qt_add_executable(VoiceAILLM ${SOURCES} ${HEADERS})
    set_target_properties(VoiceAILLM PROPERTIES
        BUNDLE TRUE
        MACOSX_BUNDLE_INFO_PLIST "${CMAKE_CURRENT_SOURCE_DIR}/ios/Info.plist"
    )
elseif(WIN32)
    # Windows executable - console app for debugging, can be changed to WIN32 for release
    qt_add_executable(VoiceAILLM ${SOURCES} ${HEADERS})
    # Uncomment for release builds:
    # set_target_properties(VoiceAILLM PROPERTIES WIN32_EXECUTABLE TRUE)
else()

qt_add_executable(VoiceAILLM ${SOURCES} ${HEADERS})
endif()

# Include directories
target_include_directories(VoiceAILLM PRIVATE include)

# Add QtKeychain include directory if found
if(QTKEYCHAIN_FOUND)
    target_include_directories(VoiceAILLM PRIVATE ${QTKEYCHAIN_INCLUDE_DIRS})
    target_compile_definitions(VoiceAILLM PRIVATE HAVE_QTKEYCHAIN)
endif()

# Add QML module for resources
qt_add_qml_module(VoiceAILLM
    URI VoiceAILLM
    VERSION 1.0
    QML_FILES
        qml/Main.qml
        qml/ChatWindow.qml
        qml/MessageDelegate.qml
        qml/VoiceButton.qml
        qml/SettingsDialog.qml
        qml/PromptManagerDialog.qml
        qml/OAuth2LoginDialog.qml
        qml/PDFDialog.qml
        qml/PDFViewer.qml
        qml/CSVDialog.qml
        qml/CSVViewer.qml
        qml/CSVViewerComponent.qml
        qml/InteractiveChart.qml
        qml/DataSeriesControl.qml
        qml/SeriesDelegate.qml
        qml/SeriesControl.qml
        qml/DataFilterControl.qml
        qml/RawDataViewer.qml
        qml/WebBrowser.qml
        qml/QmlViewerDialog.qml
        qml/SvgViewerDialog.qml
        qml/SvgHandler.qml
        qml/CommTestDialog.qml
        qml/PermissionDialog.qml
        qml/pdf_templates/diagnostic_template.qml
    RESOURCES
        data/voiceaillm.db
        resources/icons/microphone.svg
        resources/icons/settings.svg
        resources/icons/wechat.svg
        resources/icons/dingtalk.svg
        resources/icons/pdf.svg
        resources/icons/browser.svg
        resources/icons/qml-viewer.svg
        resources/icons/svg-viewer.svg
        resources/templates/diagnostic_template.html
        resources/templates/diagnostic_example.json
        resources/templates/LifeData.svg
        resources/templates/Lifedata.ui.qml
)

# Link Qt libraries
target_link_libraries(VoiceAILLM PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::QmlIntegration
    Qt6::Quick
    Qt6::QuickControls2
    Qt6::Network
    Qt6::NetworkAuth
    Qt6::SerialPort
    Qt6::Multimedia
    Qt6::TextToSpeech
    Qt6::Concurrent
    Qt6::Pdf
    Qt6::WebChannel
    Qt6::WebSockets
    Qt6::PrintSupport
    Qt6::Svg
    Qt6::Charts
)

# Link web components conditionally based on availability
if(QT_WEB_COMPONENTS)
    foreach(component ${QT_WEB_COMPONENTS})
        if(TARGET Qt6::${component})
            target_link_libraries(VoiceAILLM PRIVATE Qt6::${component})
            message(STATUS "✓ Linked Qt6::${component}")
        endif()
    endforeach()
endif()

# Platform-specific Qt libraries
if(ANDROID AND TARGET Qt6::AndroidExtras)
    target_link_libraries(VoiceAILLM PRIVATE Qt6::AndroidExtras)
endif()

# Link Qt TextToSpeech if available
if(TARGET Qt6::TextToSpeech)
    target_link_libraries(VoiceAILLM PRIVATE Qt6::TextToSpeech)
    target_compile_definitions(VoiceAILLM PRIVATE HAVE_QT_TEXTTOSPEECH)
    message(STATUS "Qt6 TextToSpeech support enabled")
else()
    message(WARNING "Qt6 TextToSpeech not found - using audio capture only")
endif()

# Google Cloud Speech API integration (cross-platform via Qt Network)
target_compile_definitions(VoiceAILLM PRIVATE 
    USE_GOOGLE_SPEECH_API=1
    GOOGLE_SPEECH_API_VERSION="v1"
)

# Link Qt Keychain if available with proper method handling
if(QTKEYCHAIN_FOUND)
    message(STATUS "Linking Qt Keychain using method: ${QTKEYCHAIN_METHOD}")
    if(QTKEYCHAIN_METHOD STREQUAL "cmake")
        # Qt6Keychain was found via find_package, but Qt6::Keychain might not exist
        if(TARGET Qt6::Keychain)
            target_link_libraries(VoiceAILLM PRIVATE Qt6::Keychain)
            message(STATUS "Linked Qt6::Keychain target")
        elseif(TARGET qt6keychain)
            target_link_libraries(VoiceAILLM PRIVATE qt6keychain)
            message(STATUS "Linked qt6keychain target")
        elseif(QTKEYCHAIN_LIBRARIES)
            target_link_libraries(VoiceAILLM PRIVATE ${QTKEYCHAIN_LIBRARIES})
            message(STATUS "Linked Qt Keychain via libraries: ${QTKEYCHAIN_LIBRARIES}")
        else()
            message(WARNING "Qt Keychain found via CMake but no valid target or libraries")
        endif()
    else()
        # Manual or pkg-config detection
        if(QTKEYCHAIN_LIBRARIES)
            target_link_libraries(VoiceAILLM PRIVATE ${QTKEYCHAIN_LIBRARIES})
            message(STATUS "Linked Qt Keychain via ${QTKEYCHAIN_METHOD}: ${QTKEYCHAIN_LIBRARIES}")
        else()
            message(WARNING "Qt Keychain found but no libraries specified")
        endif()
    endif()
    message(STATUS "Qt Keychain support enabled for secure storage")
else()
    message(WARNING "Qt Keychain not found - using basic storage (less secure)")
endif()

# Platform-specific compiler flags and definitions
if(WIN32)
    target_compile_definitions(VoiceAILLM PRIVATE
        UNICODE
        _UNICODE
        WIN32_LEAN_AND_MEAN
        NOMINMAX
    )
    if(MINGW)
        target_compile_options(VoiceAILLM PRIVATE -Wa,-mbig-obj)
    endif()
    # Windows SAPI libraries
    target_link_libraries(VoiceAILLM PRIVATE
        ole32 
        sapi
    )
    message(STATUS "Added Windows SAPI libraries for speech recognition")
elseif(APPLE)
    if(IOS)
        target_compile_definitions(VoiceAILLM PRIVATE 
            TARGET_OS_IOS=1
        )
    else()
        target_compile_definitions(VoiceAILLM PRIVATE 
            TARGET_OS_MAC=1
        )
    endif()
elseif(ANDROID)
    target_compile_definitions(VoiceAILLM PRIVATE
        ANDROID
        __ANDROID__
        HAVE_ANDROID_PERMISSIONS=1
        HAVE_ANDROID_KEYSTORE=1
    )
    # Add Android-specific sources
    target_sources(VoiceAILLM PRIVATE
        src/AndroidPermissionManager.cpp
        src/AndroidKeystoreManager.cpp
    )
    # Android JNI libraries and permissions
    target_link_libraries(VoiceAILLM PRIVATE log)
    message(STATUS "Android platform enabled with permission management and JNI support")
    message(STATUS "Android Keystore integration enabled for secure storage")
elseif(CMAKE_SYSTEM_NAME STREQUAL "Linux")
    target_compile_definitions(VoiceAILLM PRIVATE
        LINUX
        _GNU_SOURCE
    )
    # Additional libraries for Linux
    target_link_libraries(VoiceAILLM PRIVATE pthread dl)
    # Linux - check for speech recognition libraries
    find_library(POCKETSPHINX_LIB pocketsphinx)
    if(POCKETSPHINX_LIB)
        target_link_libraries(VoiceAILLM PRIVATE ${POCKETSPHINX_LIB})
        message(STATUS "Found PocketSphinx library for Linux speech recognition")
    else()
        message(WARNING "PocketSphinx not found - Linux speech recognition disabled")
    endif()
endif()

if(APPLE AND NOT CMAKE_SYSTEM_NAME STREQUAL "Darwin")
    # iOS Speech Framework
    message(STATUS "iOS speech recognition requires Speech Framework")
endif()

# Deployment configurations
if(WIN32)
    # Windows deployment
    if(CMAKE_BUILD_TYPE STREQUAL "Release")
        set_target_properties(VoiceAILLM PROPERTIES
            WIN32_EXECUTABLE TRUE
        )
    endif()
elseif(APPLE)
    if(IOS)
        # iOS deployment
        set_target_properties(VoiceAILLM PROPERTIES
            XCODE_ATTRIBUTE_PRODUCT_BUNDLE_IDENTIFIER "com.voiceaillm.app"
            XCODE_ATTRIBUTE_MARKETING_VERSION "1.0.0"
            XCODE_ATTRIBUTE_CURRENT_PROJECT_VERSION "1"
            XCODE_ATTRIBUTE_IPHONEOS_DEPLOYMENT_TARGET "11.0"
        )
    else()
        # macOS deployment
        set_target_properties(VoiceAILLM PROPERTIES
            BUNDLE TRUE
            MACOSX_BUNDLE_INFO_PLIST "${CMAKE_CURRENT_SOURCE_DIR}/macos/Info.plist"
        )
    endif()
elseif(ANDROID)
    # Android deployment
    set_target_properties(VoiceAILLM PROPERTIES
        QT_ANDROID_VERSION_NAME "1.0.0"
        QT_ANDROID_VERSION_CODE "1"
        QT_ANDROID_MIN_SDK_VERSION "23"
        QT_ANDROID_TARGET_SDK_VERSION "33"
        QT_ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android"
        QT_ANDROID_PACKAGE_NAME "com.voiceaillm.app"
        QT_ANDROID_APPLICATION_LABEL "Voice AI LLM"
    )
    
    # Ensure Android manifest and resources are included
    if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/android/AndroidManifest.xml")
        message(STATUS "✓ Android manifest found")
    else()
        message(WARNING "✗ Android manifest not found at ${CMAKE_CURRENT_SOURCE_DIR}/android/AndroidManifest.xml")
    endif()
    
    # Android permissions and features summary
    message(STATUS "Android configuration:")
    message(STATUS "  - Runtime permissions: ENABLED")
    message(STATUS "  - Android Keystore: ENABLED") 
    message(STATUS "  - Material Design: ENABLED")
    message(STATUS "  - JNI integration: ENABLED")
    message(STATUS "  - Package: com.voiceaillm.app")
    message(STATUS "  - Target SDK: 33 (Android 13)")
endif()

# Note: Qt 6.9 does not have native speech recognition components
# We use Google Cloud Speech API as primary method with Qt's cross-platform audio capture
message(STATUS "Voice recognition strategy:")
message(STATUS "  Primary: Google Cloud Speech-to-Text API (cross-platform)")
message(STATUS "  Fallback: Platform-specific speech recognition")
message(STATUS "  Audio capture: Qt6 Multimedia (cross-platform)")

# Finalize target
qt_finalize_target(VoiceAILLM) 