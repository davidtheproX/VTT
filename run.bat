@echo off
echo Running Voice AI LLM...

REM Clean environment and set ONLY UCRT64 paths for Qt6.9 DLL dependencies
set MSYS2_PATH=D:\msys64
set UCRT64_PATH=%MSYS2_PATH%\ucrt64

REM Clear PATH and set only what we need for DLLs
set PATH=%UCRT64_PATH%\bin;C:\Windows\System32;C:\Windows

echo Using CLEAN MSYS2 UCRT64 environment for Qt6.9 runtime...
echo PATH: %PATH%
echo.

REM Set Qt6.9 runtime environment variables
echo Setting Qt6.9 runtime environment...
set QT_PLUGIN_PATH=%UCRT64_PATH%\share\qt6\plugins
set QT_QML2_IMPORT_PATH=%UCRT64_PATH%\share\qt6\qml
set QML2_IMPORT_PATH=%UCRT64_PATH%\share\qt6\qml
set QT_QUICK_BACKEND=rhi
set QT_OPENGL=angle
set QT_DEBUG_PLUGINS=0
set QT_LOGGING_RULES="*=false"

echo QT_PLUGIN_PATH: %QT_PLUGIN_PATH%
echo QT_QML2_IMPORT_PATH: %QT_QML2_IMPORT_PATH%
echo QML2_IMPORT_PATH: %QML2_IMPORT_PATH%
echo QT_QUICK_BACKEND: %QT_QUICK_BACKEND%
echo QT_OPENGL: %QT_OPENGL%
echo.

REM Check if Qt6.9 plugins exist
if exist "%QT_PLUGIN_PATH%" (
    echo Qt6.9 plugins directory found: %QT_PLUGIN_PATH%
) else (
    echo WARNING: Qt6.9 plugins directory not found: %QT_PLUGIN_PATH%
)

if exist "%QT_QML2_IMPORT_PATH%" (
    echo Qt6.9 QML directory found: %QT_QML2_IMPORT_PATH%
) else (
    echo WARNING: Qt6.9 QML directory not found: %QT_QML2_IMPORT_PATH%
)
echo.

REM Run the application
if exist "build\VoiceAILLM.exe" (
    echo Starting Qt6.9 application from build\VoiceAILLM.exe...
    build\VoiceAILLM.exe
) else if exist "build\Release\VoiceAILLM.exe" (
    echo Starting Qt6.9 application from build\Release\VoiceAILLM.exe...
    build\Release\VoiceAILLM.exe
) else if exist "VoiceAILLM.exe" (
    echo Starting Qt6.9 application from VoiceAILLM.exe...
    VoiceAILLM.exe
) else (
    echo Error: VoiceAILLM.exe not found!
    echo Please build the project first using build.bat
    echo Looking for executable in:
    echo   - build\VoiceAILLM.exe
    echo   - build\Release\VoiceAILLM.exe
    echo   - VoiceAILLM.exe
    echo.
    echo Make sure the build completed successfully with Qt6.9 UCRT64.
    pause
) 