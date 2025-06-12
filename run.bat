@echo off
echo Running Voice AI LLM...

REM Use CLEAN MSYS2 UCRT64 environment for Qt6.9 runtime
echo Using CLEAN MSYS2 UCRT64 environment for Qt6.9 runtime...

REM Set Qt6.9 specific paths for UCRT64
set QML2_IMPORT_PATH=D:\msys64\ucrt64\share\qt6\qml
set QT_QUICK_BACKEND=rhi
set QT_OPENGL=angle

echo QML2_IMPORT_PATH: %QML2_IMPORT_PATH%
echo QT_QUICK_BACKEND: %QT_QUICK_BACKEND%
echo QT_OPENGL: %QT_OPENGL%

REM Check for Qt6.9 UCRT64 plugins
if exist "D:\msys64\ucrt64\share\qt6\plugins" (
    echo Qt6.9 plugins directory found: D:\msys64\ucrt64\share\qt6\plugins
    set QT_PLUGIN_PATH=D:\msys64\ucrt64\share\qt6\plugins
) else (
    echo Warning: Qt6.9 plugins directory not found
)

REM Check for Qt6.9 UCRT64 QML modules
if exist "D:\msys64\ucrt64\share\qt6\qml" (
    echo Qt6.9 QML directory found: D:\msys64\ucrt64\share\qt6\qml
) else (
    echo Warning: Qt6.9 QML directory not found
)

REM Add Qt6.9 UCRT64 to PATH for runtime
set PATH=D:\msys64\ucrt64\bin;%PATH%

echo.
if exist "build\VoiceAILLM.exe" (
    echo Starting Qt6.9 application from build\VoiceAILLM.exe...
    cd build
    VoiceAILLM.exe
    cd ..
) else (
    echo Error: Application not found! Please build first using build.bat
    pause
)

echo.
echo Application closed.
pause 