@echo off
setlocal

rem Serve from the outputs folder so the existing /ai-platform-interview-lab/ URL works.
for %%I in ("%~dp0..") do set "SERVER_DIR=%%~fI"
set "DASHBOARD_URL=http://127.0.0.1:8080/ai-platform-interview-lab/index.html"

rem Avoid opening the wrong app if another server already owns port 8080.
netstat -ano | findstr ":8080" | findstr "LISTENING" >nul
if not errorlevel 1 (
    echo Port 8080 is already in use.
    echo If the dashboard is already open, use: %DASHBOARD_URL%
    echo Otherwise close the other server and run this file again.
    pause
    exit /b 1
)

where py >nul 2>&1
if not errorlevel 1 (
    start "AI Platform Interview Lab - local server" /D "%SERVER_DIR%" cmd /k "py -3 -m http.server 8080 --bind 127.0.0.1"
) else (
    where python >nul 2>&1
    if errorlevel 1 (
        echo Python 3 was not found. Install Python 3, then run this file again.
        pause
        exit /b 1
    )
    start "AI Platform Interview Lab - local server" /D "%SERVER_DIR%" cmd /k "python -m http.server 8080 --bind 127.0.0.1"
)

timeout /t 2 /nobreak >nul
start "" "%DASHBOARD_URL%"
echo Dashboard opened. Keep the server window running; press Ctrl+C there to stop it.
endlocal
