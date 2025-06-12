#ifndef PLATFORMDETECTION_H
#define PLATFORMDETECTION_H

#include <QtGlobal>

// Platform detection macros with guards to prevent redefinition
#ifdef Q_OS_WIN
    #ifndef PLATFORM_WINDOWS
        #define PLATFORM_WINDOWS
    #endif
    #ifndef PLATFORM_NAME
        #define PLATFORM_NAME "Windows"
    #endif
    #ifdef Q_OS_WIN32
        #ifndef PLATFORM_WIN32
            #define PLATFORM_WIN32
        #endif
    #endif
    #ifdef Q_OS_WIN64
        #ifndef PLATFORM_WIN64
            #define PLATFORM_WIN64
        #endif
    #endif
#elif defined(Q_OS_ANDROID)
    #ifndef PLATFORM_ANDROID
        #define PLATFORM_ANDROID
    #endif
    #ifndef PLATFORM_NAME
        #define PLATFORM_NAME "Android"
    #endif
    #ifndef PLATFORM_MOBILE
        #define PLATFORM_MOBILE
    #endif
    #ifndef PLATFORM_LINUX_BASED
        #define PLATFORM_LINUX_BASED
    #endif
#elif defined(Q_OS_IOS)
    #ifndef PLATFORM_IOS
        #define PLATFORM_IOS
    #endif
    #ifndef PLATFORM_NAME
        #define PLATFORM_NAME "iOS"
    #endif
    #ifndef PLATFORM_MOBILE
        #define PLATFORM_MOBILE
    #endif
    #ifndef PLATFORM_APPLE
        #define PLATFORM_APPLE
    #endif
#elif defined(Q_OS_MACOS)
    #ifndef PLATFORM_MACOS
        #define PLATFORM_MACOS
    #endif
    #ifndef PLATFORM_NAME
        #define PLATFORM_NAME "macOS"
    #endif
    #ifndef PLATFORM_DESKTOP
        #define PLATFORM_DESKTOP
    #endif
    #ifndef PLATFORM_APPLE
        #define PLATFORM_APPLE
    #endif
#elif defined(Q_OS_LINUX)
    #ifndef PLATFORM_LINUX
        #define PLATFORM_LINUX
    #endif
    #ifndef PLATFORM_NAME
        #define PLATFORM_NAME "Linux"
    #endif
    #ifndef PLATFORM_DESKTOP
        #define PLATFORM_DESKTOP
    #endif
    #ifndef PLATFORM_LINUX_BASED
        #define PLATFORM_LINUX_BASED
    #endif
    
    // Check for HarmonyOS (runs on Linux kernel)
    #if defined(PLATFORM_HARMONYOS) || defined(__HARMONYOS__)
        #ifdef PLATFORM_NAME
            #undef PLATFORM_NAME
        #endif
        #define PLATFORM_NAME "HarmonyOS"
        #ifndef PLATFORM_HARMONYOS
            #define PLATFORM_HARMONYOS
        #endif
        #ifndef PLATFORM_MOBILE
            #define PLATFORM_MOBILE
        #endif
    #endif
#elif defined(Q_OS_UNIX)
    #ifndef PLATFORM_UNIX
        #define PLATFORM_UNIX
    #endif
    #ifndef PLATFORM_NAME
        #define PLATFORM_NAME "Unix"
    #endif
    #ifndef PLATFORM_DESKTOP
        #define PLATFORM_DESKTOP
    #endif
#else
    #ifndef PLATFORM_UNKNOWN
        #define PLATFORM_UNKNOWN
    #endif
    #ifndef PLATFORM_NAME
        #define PLATFORM_NAME "Unknown"
    #endif
#endif

// Architecture detection
#ifdef Q_PROCESSOR_X86_64
    #define PLATFORM_ARCH_X64
    #define PLATFORM_ARCH_NAME "x64"
#elif defined(Q_PROCESSOR_X86_32)
    #define PLATFORM_ARCH_X86
    #define PLATFORM_ARCH_NAME "x86"
#elif defined(Q_PROCESSOR_ARM_64)
    #define PLATFORM_ARCH_ARM64
    #define PLATFORM_ARCH_NAME "ARM64"
#elif defined(Q_PROCESSOR_ARM)
    #define PLATFORM_ARCH_ARM
    #define PLATFORM_ARCH_NAME "ARM"
#else
    #define PLATFORM_ARCH_UNKNOWN
    #define PLATFORM_ARCH_NAME "Unknown"
#endif

// Platform capability detection
#ifdef PLATFORM_WINDOWS
    #define PLATFORM_HAS_NATIVE_TTS
    #define PLATFORM_HAS_SYSTEM_KEYCHAIN
    #define PLATFORM_SECURE_STORAGE_AVAILABLE
#endif

#ifdef PLATFORM_APPLE
    #define PLATFORM_HAS_NATIVE_TTS
    #define PLATFORM_HAS_SYSTEM_KEYCHAIN
    #define PLATFORM_SECURE_STORAGE_AVAILABLE
#endif

#ifdef PLATFORM_ANDROID
    #define PLATFORM_HAS_NATIVE_TTS
    #define PLATFORM_HAS_JNI
    // Android Keystore available via JNI
    #define PLATFORM_SECURE_STORAGE_AVAILABLE
#endif

#ifdef PLATFORM_HARMONYOS
    #define PLATFORM_HAS_NATIVE_TTS
    // HarmonyOS has its own secure storage system
    #define PLATFORM_SECURE_STORAGE_AVAILABLE
#endif

#ifdef PLATFORM_LINUX
    #define PLATFORM_HAS_ESPEAK
    // Linux uses libsecret or similar
    #define PLATFORM_SECURE_STORAGE_AVAILABLE
#endif

// Feature availability macros
#ifdef PLATFORM_MOBILE
    #define PLATFORM_HAS_TOUCH_INTERFACE
    #define PLATFORM_HAS_ACCELEROMETER
    #define PLATFORM_HAS_GPS
#endif

#ifdef PLATFORM_DESKTOP
    #define PLATFORM_HAS_KEYBOARD
    #define PLATFORM_HAS_MOUSE
    #define PLATFORM_HAS_MULTIPLE_WINDOWS
#endif

// Compiler detection
#ifdef _MSC_VER
    #define COMPILER_MSVC
    #define COMPILER_NAME "MSVC"
#elif defined(__GNUC__)
    #define COMPILER_GCC
    #define COMPILER_NAME "GCC"
#elif defined(__clang__)
    #define COMPILER_CLANG
    #define COMPILER_NAME "Clang"
#elif defined(__MINGW32__) || defined(__MINGW64__)
    #define COMPILER_MINGW
    #define COMPILER_NAME "MinGW"
#else
    #define COMPILER_UNKNOWN
    #define COMPILER_NAME "Unknown"
#endif

// Debug/Release detection
#ifdef QT_NO_DEBUG
    #define BUILD_RELEASE
    #define BUILD_TYPE "Release"
#else
    #define BUILD_DEBUG
    #define BUILD_TYPE "Debug"
#endif

// Utility macros for platform-specific code
#define PLATFORM_SPECIFIC_CODE(platform, code) \
    do { \
        if constexpr (std::is_same_v<decltype(platform), std::true_type>) { \
            code \
        } \
    } while(0)

// Function to get platform information at runtime
inline const char* getPlatformInfo() {
    return PLATFORM_NAME " (" PLATFORM_ARCH_NAME ") - " COMPILER_NAME " - " BUILD_TYPE;
}

// Platform-specific includes
#ifdef PLATFORM_WINDOWS
    #include <windows.h>
    #ifdef PLATFORM_HAS_SYSTEM_KEYCHAIN
        // Windows Credential Manager
    #endif
#endif

#ifdef PLATFORM_ANDROID
    #include <QJniObject>
    #include <QJniEnvironment>
#endif

#ifdef PLATFORM_APPLE
    #ifdef PLATFORM_IOS
        #include <Foundation/Foundation.h>
        #include <UIKit/UIKit.h>
    #else
        #include <Foundation/Foundation.h>
        #include <AppKit/AppKit.h>
    #endif
#endif

#ifdef PLATFORM_LINUX
    #include <unistd.h>
    #include <sys/utsname.h>
#endif

#endif // PLATFORMDETECTION_H 