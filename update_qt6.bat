@echo off
echo === Updating Qt6 in MSYS2 UCRT64 ===
echo.

echo Updating MSYS2 package database...
D:\msys64\usr\bin\bash.exe -lc "pacman -Sy"

echo.
echo Current Qt6 packages:
D:\msys64\usr\bin\bash.exe -lc "pacman -Q | grep qt6"

echo.
echo Updating Qt6 packages...
D:\msys64\usr\bin\bash.exe -lc "pacman -S --noconfirm mingw-w64-ucrt-x86_64-qt6-base mingw-w64-ucrt-x86_64-qt6-declarative mingw-w64-ucrt-x86_64-qt6-multimedia mingw-w64-ucrt-x86_64-qt6-speech mingw-w64-ucrt-x86_64-qt6-pdf mingw-w64-ucrt-x86_64-qt6-networkauth mingw-w64-ucrt-x86_64-qt6-tools"

echo.
echo Updated Qt6 packages:
D:\msys64\usr\bin\bash.exe -lc "pacman -Q | grep qt6"

echo.
echo Update complete! Please try building again.
pause 