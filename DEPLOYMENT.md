# 🚀 GitHub Pages Deployment Guide

This guide will help you deploy your Math Flash application to GitHub Pages.

## Prerequisites

- GitHub account
- Git installed on your computer
- Flutter SDK installed

## Step-by-Step Deployment

### 1. Create a GitHub Repository

1. Go to [GitHub](https://github.com) and sign in
2. Click the "+" icon in the top right corner
3. Select "New repository"
4. Name your repository (e.g., `mathflash`)
5. Make it public (required for free GitHub Pages)
6. Don't initialize with README (we already have one)
7. Click "Create repository"

### 2. Push Your Code to GitHub

Open a terminal/command prompt in your project directory and run:

```bash
# Initialize git repository (if not already done)
git init

# Add all files
git add .

# Commit the changes
git commit -m "Initial commit: Math Flash application"

# Add the remote repository (replace with your repository URL)
git remote add origin https://github.com/YOUR_USERNAME/mathflash.git

# Push to GitHub
git branch -M main
git push -u origin main
```

### 3. Build the Web Version

Run one of these commands in your project directory:

**Windows:**
```bash
deploy.bat
```

**Linux/Mac:**
```bash
chmod +x deploy.sh
./deploy.sh
```

**Manual:**
```bash
flutter build web --release
```

### 4. Deploy to GitHub Pages

#### Option A: Manual Deployment

1. Go to your repository on GitHub
2. Click on "Settings" tab
3. Scroll down to "Pages" section
4. Under "Source", select "Deploy from a branch"
5. Choose "main" branch
6. Set folder to `/docs`
7. Click "Save"

8. Create a `docs` folder in your repository root
9. Copy all contents from `build/web/` to the `docs/` folder
10. Commit and push the changes:

```bash
mkdir docs
cp -r build/web/* docs/
git add docs/
git commit -m "Add web build for GitHub Pages"
git push
```

#### Option B: Automatic Deployment (Recommended)

1. The GitHub Actions workflow (`.github/workflows/deploy.yml`) will automatically deploy your app
2. Just push your changes to the main branch
3. Go to your repository → Actions tab to monitor the deployment
4. Once complete, your app will be available at `https://YOUR_USERNAME.github.io/mathflash`

### 5. Verify Deployment

1. Wait a few minutes for GitHub Pages to build and deploy
2. Visit your app at: `https://YOUR_USERNAME.github.io/mathflash`
3. Test all features to ensure everything works correctly

## Troubleshooting

### Common Issues

1. **404 Error**
   - Ensure the repository is public
   - Check that the correct branch and folder are selected in Pages settings
   - Wait a few minutes for the initial deployment

2. **Build Failures**
   - Check the Actions tab for error messages
   - Ensure all dependencies are properly declared in `pubspec.yaml`
   - Verify that Flutter version is compatible

3. **Assets Not Loading**
   - Ensure all assets are declared in `pubspec.yaml`
   - Check that file paths are correct
   - Verify that asset files are included in the repository

### Performance Optimization

1. **Enable Compression**
   - GitHub Pages automatically serves compressed files
   - Ensure your build uses release mode: `flutter build web --release`

2. **Optimize Assets**
   - Compress images before adding to assets
   - Use appropriate image formats (PNG for graphics, JPG for photos)

3. **Cache Strategy**
   - Flutter web automatically handles caching
   - Consider using service workers for offline functionality

## Custom Domain (Optional)

If you want to use a custom domain:

1. Purchase a domain name
2. Add a `CNAME` file to your repository root with your domain
3. Update your domain's DNS settings to point to `YOUR_USERNAME.github.io`
4. In repository Settings → Pages, enter your custom domain

## Support

If you encounter issues:

1. Check the [GitHub Pages documentation](https://docs.github.com/en/pages)
2. Review the [Flutter web deployment guide](https://flutter.dev/docs/deployment/web)
3. Create an issue in your repository with detailed error information

---

🎉 **Congratulations!** Your Math Flash application is now live on GitHub Pages!

