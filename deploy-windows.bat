@echo off
REM Khabir Portfolio Deployment Script for Windows
REM This script uploads files to VPS and deploys the portfolio

echo 🚀 Starting Khabir Portfolio deployment...

REM Check if required files exist
if not exist "khabir.html" (
    echo ❌ Error: khabir.html not found!
    pause
    exit /b 1
)

if not exist "Dockerfile" (
    echo ❌ Error: Dockerfile not found!
    pause
    exit /b 1
)

echo 📁 Uploading files to VPS...
scp -r . khabeer:/root/khabir-portfolio/

if %errorlevel% neq 0 (
    echo ❌ Error: Failed to upload files to VPS
    pause
    exit /b 1
)

echo 🔧 Deploying on VPS...
ssh khabeer "cd /root/khabir-portfolio && chmod +x deploy.sh && ./deploy.sh"

if %errorlevel% neq 0 (
    echo ❌ Error: Deployment failed
    pause
    exit /b 1
)

echo ✅ Deployment completed successfully!
echo 🌐 Your portfolio is now available at: http://YOUR_VPS_IP:8080
pause
