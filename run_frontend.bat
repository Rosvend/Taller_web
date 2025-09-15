@echo off
cls
echo ==========================================
echo   Starting Vue.js Frontend (Vite)
echo ==========================================
echo.

REM Check if frontend folder exists
if not exist "%~dp0frontend" (
    echo ERROR: frontend folder not found!
    echo Make sure you're running this from the project root directory.
    pause
    exit /b 1
)

cd /d "%~dp0frontend"

echo Current directory: %CD%
echo Installing Node.js dependencies...
call npm install
if %errorlevel% neq 0 (
    echo ERROR: npm install failed!
    pause
    exit /b 1
)

echo.
echo Starting development server...
echo Frontend URL: http://localhost:5173
echo.
echo Press Ctrl+C to stop the server
echo ==========================================
echo.

call npm run dev