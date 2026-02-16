@echo off
cd /d "%~dp0"

set LOVE_PATH=C:\Program Files\LOVE\love.exe

if not exist "%LOVE_PATH%" (
    echo ERROR: love.exe not found at:
    echo %LOVE_PATH%
    echo.
    echo Edit LOVE_PATH in this file to match your install.
    pause
    exit /b 1
)

"%LOVE_PATH%" .

