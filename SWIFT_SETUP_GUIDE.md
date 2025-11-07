# 🎭 Charades iOS App - Swift Setup Guide

This guide will help you create a native iOS app that wraps your Charades web game.

## Prerequisites

- macOS with Xcode 14+ installed
- Apple Developer Account (free tier is fine)
- iPhone or iPhone simulator for testing

## Step 1: Create a New Xcode Project

1. Open **Xcode**
2. Click **Create a new Xcode project**
3. Choose **iOS** → **App**
4. Configure:
   - **Product Name:** Charades
   - **Team:** Your Apple ID or team
   - **Organization Identifier:** com.yourname.charades
   - **Interface:** SwiftUI
   - **Lifecycle:** SwiftUI App

## Step 2: Add Swift Files

Copy these three Swift files into your Xcode project:

1. **ContentView.swift** - Main UI and WebView
2. **CharadesApp.swift** - App entry point and orientation handling
3. **WebViewDelegate.swift** - WebView delegate methods

To add files to Xcode:
1. File → Add Files to "Charades"
2. Select the .swift files
3. Check "Copy items if needed"
4. Add to target "Charades"

## Step 3: Add HTML File to Project

Two options:

### Option A: Bundle HTML File (Recommended for App Store)

1. Drag **index.html** into Xcode's project navigator
2. Check "Copy items if needed"
3. Ensure it's added to the **Charades** target
4. In Build Phases → Copy Bundle Resources, verify index.html is there

The app will load the HTML file from the app bundle.

### Option B: Load from Local Server (For Development)

If running a local web server on port 8000:
- The app will automatically fall back to `http://localhost:8000`
- Useful for live development and testing

## Step 4: Configure App Info

1. Select the **Charades** project in navigator
2. Select **Info** tab
3. Add these keys:

```
App Display Name: Charades
Bundle Identifier: com.yourname.charades
Version: 1.0
Build: 1
Deployment Target: iOS 14.0
Supported Interface Orientations:
  - Portrait
  - Landscape Left
  - Landscape Right
```

## Step 5: Update Info.plist (If Needed)

Add the following to your Info.plist for better device support:

```xml
<key>UIRequiredDeviceCapabilities</key>
<array>
    <string>accelerometer</string>
</array>
<key>UISupportedInterfaceOrientations</key>
<array>
    <string>UIInterfaceOrientationPortrait</string>
    <string>UIInterfaceOrientationLandscapeLeft</string>
    <string>UIInterfaceOrientationLandscapeRight</string>
</array>
<key>UISupportedInterfaceOrientations~ipad</key>
<array>
    <string>UIInterfaceOrientationPortrait</string>
    <string>UIInterfaceOrientationPortraitUpsideDown</string>
    <string>UIInterfaceOrientationLandscapeLeft</string>
    <string>UIInterfaceOrientationLandscapeRight</string>
</array>
```

## Step 6: Build and Test

1. Select a simulator or device
2. Product → Build (⌘B)
3. Product → Run (⌘R)

### Troubleshooting Build Errors

**Error: "index.html not found"**
- Ensure index.html is in Build Phases → Copy Bundle Resources
- File → Add Files to "Charades" → select index.html

**Error: WebView won't load**
- Check Console output for errors
- Verify file path is correct
- Try loading from localhost server as fallback

**Orientation not changing**
- In ContentView.swift, the app supports all orientations
- Lock/unlock from device Settings → Display & Brightness

## Step 7: Enhance the App (Optional)

### Add App Icon

1. Select Assets.xcassets in navigator
2. Drag icon images into AppIcon set
3. Requires multiple sizes (see Xcode's guidance)

### Add Launch Screen

1. Create LaunchScreen.storyboard or use SwiftUI
2. Set as launch screen in project settings
3. Display while HTML loads

### Add Native Features

The WebView communicates with JavaScript. You can add features like:

```swift
// Example: Call JavaScript from Swift
webView.evaluateJavaScript("alert('Hello from Swift!')")

// Example: Capture device orientation
let orientation = UIDevice.current.orientation
// Pass to JavaScript via WebView message handler
```

## Step 8: Publish to App Store (Optional)

1. Enroll in Apple Developer Program ($99/year)
2. Create App Store Connect entry
3. Configure signing certificates and provisioning profiles
4. Product → Archive
5. Upload to App Store

## Development Tips

### Testing Different Devices

1. Product → Destination → Choose simulator/device
2. Test on iPhone SE, iPhone 14 Pro, iPhone 14 Pro Max, iPad
3. Use Safari Developer Tools: Develop → Simulator → Charades

### Live Reloading

While developing:
1. Keep index.html in a local web server
2. Update HTML/CSS/JS
3. Reload in app (⌘R in Safari dev tools)
4. Changes appear instantly

### Debug Console

Access JavaScript console:
1. Safari → Develop → Charades (Simulator) → index.html
2. View logs, errors, and warnings
3. Run JavaScript commands directly

### Performance Optimization

```swift
// In ContentView.swift, optimize for performance:
webView.configuration.mediaTypesRequiringUserActionForPlayback = []
// Allows autoplay of audio (for sound effects)
```

## File Structure

```
Charades/
├── CharadesApp.swift          # App entry point
├── ContentView.swift          # Main UI with WebView
├── WebViewDelegate.swift      # WebView handlers
├── index.html                 # Your game (in Bundle)
└── Assets.xcassets            # Icons and images
```

## Key Features Enabled

✅ Full device orientation support (portrait + landscape)
✅ DeviceOrientation API for tilt controls
✅ Web Audio API for sound effects
✅ Fullscreen mode support
✅ Touch screen optimization
✅ Safe area handling (notches, home indicators)
✅ Dark mode support
✅ All modern web features

## Troubleshooting

### App crashes on launch
- Check Console for Swift errors
- Ensure CharadesApp.swift has @main attribute
- Verify ContentView.swift compiles

### WebView appears blank
- Verify index.html exists in Build Phases
- Check file path in ContentView.swift
- Enable Safari dev tools to debug

### Tilt controls don't work
- Enable DeviceOrientation in app settings
- Check iOS Settings → Privacy → Motion & Fitness
- Grant app permission when prompted

### Sounds don't play
- Verify mediaTypesRequiringUserActionForPlayback = []
- Check device mute switch is off
- Test with Safari dev tools console

## Support

For questions or issues:
1. Check Xcode error messages carefully
2. Enable Console logging
3. Test in Safari first to isolate web app issues
4. Use Xcode debugger to inspect WebView state

## Next Steps

1. ✅ Follow steps 1-6 above
2. ✅ Build and run on simulator
3. ✅ Test all game features
4. ✅ Customize app icon and launch screen
5. ✅ Deploy to App Store (optional)

Enjoy your native iOS Charades app! 🎭🎮
