@echo off
REM ===== Twenty CRM - one-click local start (Windows) =====
REM Run this by double-clicking, or from a terminal in this folder.

cd /d "%~dp0"

where docker >nul 2>nul
if errorlevel 1 (
  echo [ERROR] Docker is not installed or not on PATH.
  echo Install Docker Desktop from https://www.docker.com/products/docker-desktop/
  echo Then make sure Docker Desktop is RUNNING and try again.
  pause
  exit /b 1
)

REM .env is git-ignored, so create it from the template on first run.
if not exist ".env" (
  echo Creating .env from env.local-docker ...
  copy /Y "env.local-docker" ".env" >nul
)

echo Pulling images and starting Twenty CRM...
docker compose pull
docker compose up -d
if errorlevel 1 (
  echo [ERROR] Failed to start. Is Docker Desktop running?
  pause
  exit /b 1
)

echo.
echo ============================================================
echo  Twenty is starting up. First boot runs DB migrations and
echo  can take 1-3 minutes. Then open:   http://localhost:3300
echo ============================================================
echo.
echo  Useful commands (run in this folder):
echo    docker compose logs -f server   ^<- watch startup logs
echo    docker compose down             ^<- stop everything
echo    docker compose down -v          ^<- stop AND wipe all data
echo.
pause
