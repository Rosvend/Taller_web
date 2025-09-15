@echo off
cls
echo ==========================================
echo   Starting FastAPI Backend Server
echo ==========================================
echo.

cd backend

echo Installing Python dependencies...
pip install -r ../requirements.txt
echo.

echo Starting server...
echo Backend URL: http://localhost:8000
echo API Documentation: http://localhost:8000/docs
echo.
echo Press Ctrl+C to stop the server
echo ==========================================
echo.

uvicorn main:app --reload --host 0.0.0.0 --port 8000
