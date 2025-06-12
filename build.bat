@echo off
echo Starting Voice AI LLM build...
echo.

echo.
echo Using CLEAN MSYS2 UCRT64 environment...
set "PATH=D:\msys64\ucrt64\bin;C:\Windows\System32;C:\Windows"
set "CMAKE_PREFIX_PATH=D:\msys64\ucrt64"
set "Qt6_DIR=D:\msys64\ucrt64\lib\cmake\Qt6"
set "PKG_CONFIG_PATH=D:\msys64\ucrt64\lib\pkgconfig"

echo PATH: %PATH%
echo.

echo Tool versions:
cmake --version
echo.
qmake --version 2>nul || echo 'qmake' not found but continuing with cmake...
echo.

echo Creating build directory...
if not exist build mkdir build

echo.
echo Configuring with CMake (Qt6 UCRT64 ONLY)...
cd build
cmake .. -G "MinGW Makefiles" ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_PREFIX_PATH="D:\msys64\ucrt64" ^
    -DQt6_DIR="D:\msys64\ucrt64\lib\cmake\Qt6" ^
    -DCMAKE_C_COMPILER="D:\msys64\ucrt64\bin\gcc.exe" ^
    -DCMAKE_CXX_COMPILER="D:\msys64\ucrt64\bin\g++.exe"

if %ERRORLEVEL% neq 0 (
    echo Configuration failed!
    cd ..
    pause
    exit /b 1
)

echo.
echo Building project with maximum parallelism (48 threads)...
cmake --build . --config Release --parallel 48

if %ERRORLEVEL% neq 0 (
    echo Build failed!
    cd ..
    pause
    exit /b 1
)

cd ..
echo.
echo Build complete! Executable is in build/ directory
pause 