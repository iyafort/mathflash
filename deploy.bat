@echo off
REM Math Flash - Web Deployment Script for Windows
REM This script builds the Flutter web app and prepares it for GitHub Pages deployment

echo 🚀 Starting Math Flash Web Deployment...

REM Check if Flutter is installed
flutter --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Flutter is not installed or not in PATH. Please install Flutter first.
    pause
    exit /b 1
)

REM Clean previous builds
echo 🧹 Cleaning previous builds...
flutter clean

REM Get dependencies
echo 📦 Getting dependencies...
flutter pub get

REM Build web version
echo 🏗️ Building web version...
flutter build web --release

REM Check if build was successful
if %errorlevel% equ 0 (
    echo ✅ Web build completed successfully!
    echo 📁 Build files are located in: build/web/
    echo.
    echo 🌐 To deploy to GitHub Pages:
    echo 1. Create a new repository on GitHub
    echo 2. Push this project to the repository
    echo 3. Go to repository Settings ^> Pages
    echo 4. Set source to 'Deploy from a branch'
    echo 5. Choose 'gh-pages' branch or set source to '/docs'
    echo 6. Copy contents of build/web/ to the selected location
    echo.
    echo 🔗 Your app will be available at: https://your-username.github.io/repository-name
) else (
    echo ❌ Build failed. Please check the error messages above.
    pause
    exit /b 1
)

pause

