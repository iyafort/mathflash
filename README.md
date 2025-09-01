# Math Flash - Interactive Math Flashcards

A Flutter-based interactive math flashcard application designed to help students practice basic arithmetic operations through engaging digital drills.

## 🎯 Features

- **Quick Start Drills**: Pre-configured drills for Addition, Subtraction, Multiplication, and Division
- **Customizable Settings**: Adjust number of items, operators, speed, and digit limits
- **Two Display Modes**:
  - Single Card Mode: Auto-advancing flashcards with pause/resume functionality
  - Quiz Mode: Show multiple cards at once (up to 10 per set)
- **Answer Key Generation**: Automatically generates downloadable answer keys
- **Cross-Platform**: Works on Web, Windows, and other platforms
- **Responsive Design**: Adapts to different screen sizes

## 🚀 Live Demo

[View the live web version here](https://your-username.github.io/mathflash)

## 📋 Prerequisites

- Flutter SDK (3.7.0 or higher)
- Dart SDK
- Git

## 🛠️ Installation & Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/mathflash.git
   cd mathflash
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   # For web
   flutter run -d chrome
   
   # For Windows
   flutter run -d windows
   ```

## 🏗️ Building for Production

### Web Build
```bash
flutter build web --release
```

### Windows Build
```bash
flutter build windows --release
```

## 📁 Project Structure

```
mathflash/
├── lib/
│   └── main.dart          # Main application code
├── assets/
│   ├── BG.png            # Background pattern
│   ├── Logo.png          # Application logo
│   ├── ico.png           # App icon
│   └── HowTo.jpg         # Instructions image
├── web/                  # Web-specific files
├── windows/              # Windows-specific files
└── pubspec.yaml          # Dependencies and configuration
```

## 🎮 How to Use

### Quick Start
1. Click on any operation button (Addition, Subtraction, Multiplication, Division)
2. The app will automatically start with 30 pre-configured questions
3. Flashcards will auto-advance every 8 seconds
4. Click on cards to reveal answers

### Custom Drills
1. Click "Customize Drill" to open settings
2. Adjust the following parameters:
   - Number of items (5-50)
   - Operators (+, -, ×, ÷, %)
   - Card display time (5-60 seconds)
   - Maximum digits for numerators/denominators (1-3)
   - Number of flashcards on screen (1-5)
   - Allow negative integers
   - Quiz mode (show all cards at once)
3. Click "Start" to begin

### Navigation
- **Single Card Mode**: Use pause/resume button to control auto-advance
- **Quiz Mode**: Use navigation buttons to move between sets
- **Toggle Answers**: Show/hide all answers at once
- **Settings**: Access via the gear icon in the top-right

## 🌐 Web Deployment

### GitHub Pages Deployment

1. **Create a new repository on GitHub**
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git branch -M main
   git remote add origin https://github.com/your-username/mathflash.git
   git push -u origin main
   ```

2. **Build the web version**
   ```bash
   flutter build web --release
   ```

3. **Deploy to GitHub Pages**
   - Go to your repository settings
   - Navigate to "Pages"
   - Select "Deploy from a branch"
   - Choose "gh-pages" branch or "main" branch with `/docs` folder
   - Set source to `/docs` or `/build/web`

4. **Alternative: Use GitHub Actions**
   Create `.github/workflows/deploy.yml`:
   ```yaml
   name: Deploy to GitHub Pages
   on:
     push:
       branches: [ main ]
   jobs:
     build:
       runs-on: ubuntu-latest
       steps:
         - uses: actions/checkout@v2
         - uses: subosito/flutter-action@v2
           with:
             flutter-version: '3.7.0'
         - run: flutter pub get
         - run: flutter build web --release
         - name: Deploy
           uses: peaceiris/actions-gh-pages@v3
           with:
             github_token: ${{ secrets.GITHUB_TOKEN }}
             publish_dir: ./build/web
   ```

## 🔧 Configuration

### Customizing Settings
- **Number of Items**: 5-50 (increments of 5)
- **Operators**: Select from +, -, ×, ÷, %
- **Speed**: 5-60 seconds per card
- **Digits**: 1-3 digits for numerators and denominators
- **Negative Integers**: Toggle to allow negative numbers

### Answer Key Generation
- Answer keys are automatically generated when questions are created
- Web version: Downloads as `.txt` file
- Windows version: Saves to Downloads or Documents folder
- File naming: `Month_DD_YYYY_HH_MM.txt` (e.g., `Mar_01_2025_14_30.txt`)

## 🐛 Troubleshooting

### Common Issues

1. **Build Errors**
   - Ensure Flutter SDK is up to date
   - Run `flutter doctor` to check for issues
   - Clear build cache: `flutter clean`

2. **Web Build Issues**
   - Check that all assets are properly declared in `pubspec.yaml`
   - Ensure `dart:html` imports are only used in web builds

3. **Windows Build Issues**
   - Enable Developer Mode in Windows settings
   - Run as Administrator if needed
   - Check symlink support requirements

### Performance Tips
- Use release builds for production: `flutter build web --release`
- Optimize images and assets
- Consider using `--no-tree-shake-icons` if icon issues occur

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Rea Mae Ragay**
- Math Flash - Interactive Math Flashcards
- Designed for educational use

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📞 Support

If you encounter any issues or have questions:
1. Check the troubleshooting section above
2. Search existing issues in the repository
3. Create a new issue with detailed information

---

**Math Flash** - Making math practice engaging and interactive! 🧮✨
