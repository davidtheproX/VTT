@echo off
echo Starting Voice AI LLM build...
echo.

REM Use CLEAN MSYS2 UCRT64 environment
echo Using CLEAN MSYS2 UCRT64 environment...
set PATH=D:\msys64\ucrt64\bin;C:\Windows\System32;C:\Windows
echo PATH: %PATH%

echo.
echo Tool versions:
cmake --version
echo.
where qmake >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo 'qmake' not found but continuing with cmake...
) else (
    qmake --version
)

echo.
echo Creating build directory...
if not exist build mkdir build

echo.
echo Configuring with CMake (Qt6 UCRT64 ONLY)...
cd build
cmake .. -G "MinGW Makefiles" -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=D:\msys64\ucrt64 2>../build_errors.txt
if %ERRORLEVEL% neq 0 (
    echo CMake configuration failed! Check build_errors.txt
    cd ..
    pause
    exit /b 1
)

echo.
echo Building project with maximum parallelism (48 threads)...
mingw32-make -j48 2>>../build_errors.txt
if %ERRORLEVEL% neq 0 (
    echo Build failed!
    cd ..
    type build_errors.txt | tail -50
    pause
    exit /b 1
)

cd ..
echo.
echo Build complete! Executable is in build/ directory
pause 