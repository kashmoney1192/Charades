# 🎭 Charades - iOS Swift App

Convert your web-based Charades game into a native iOS app!

## 📁 Swift Files Included

### Core Files (Required)
1. **CharadesApp.swift** - App entry point with SwiftUI
2. **ContentView.swift** - Main UI and WebView integration
3. **WebViewDelegate.swift** - WebView event handling

### Optional Enhancements
- **OptionalEnhancements.swift** - Advanced features like haptics, native sharing, JS bridge

### Documentation
- **SWIFT_SETUP_GUIDE.md** - Comprehensive step-by-step guide
- **XCODE_SETUP.md** - Quick reference for Xcode configuration
- **SWIFT_README.md** - This file

## 🚀 Quick Start

### Option 1: Simple Setup (Recommended for Beginners)
1. Create new Xcode project (iOS → App, SwiftUI)
2. Copy **CharadesApp.swift** (replace default)
3. Copy **ContentView.swift** and **WebViewDelegate.swift**
4. Drag **index.html** into Xcode project
5. Build and run (⌘R)

### Option 2: Advanced Setup (With Optional Features)
Follow Option 1, then:
6. Also include **OptionalEnhancements.swift**
7. Update ContentView to use AdvancedWebViewContainer
8. Add native communication between JS and Swift

## 📋 Features

### Out of the Box ✅
- Full WebView integration
- Portrait and landscape orientation support
- DeviceOrientation API for tilt controls
- Web Audio API for sound effects
- Touch screen optimization
- Safe area handling (notches, home indicators)
- Dark mode support
- Fullscreen mode
- Proper scaling on all device sizes

### With Optional Enhancements ✨
- Haptic feedback (vibration)
- Native sharing (Share Score)
- JavaScript to Swift communication bridge
- Custom status bar handling
- Performance optimizations

## 📖 File Structure

```
Charades/
├── Core Swift Files
│   ├── CharadesApp.swift          # App entry point
│   ├── ContentView.swift          # Main UI
│   └── WebViewDelegate.swift      # Event handling
│
├── Optional
│   └── OptionalEnhancements.swift # Advanced features
│
├── Web App
│   └── index.html                 # Your game (copy to Xcode)
│
└── Documentation
    ├── SWIFT_SETUP_GUIDE.md       # Complete guide
    ├── XCODE_SETUP.md             # Quick reference
    └── SWIFT_README.md            # This file
```

## 🔧 How Each File Works

### CharadesApp.swift
- Entry point using @main decorator
- Configures app orientation (portrait + landscape)
- Sets up App Delegate for window management
- Minimal, clean setup

### ContentView.swift
- SwiftUI view with gradient background
- WebViewContainer that loads index.html
- Handles bundle resource loading
- Fallback to localhost for development

### WebViewDelegate.swift
- Handles JavaScript alerts and prompts
- Manages navigation decisions
- Logs page load success/errors
- Can be extended for more features

### OptionalEnhancements.swift
- Advanced WebView with JS-to-Swift bridge
- Haptic feedback support
- Native sharing capabilities
- Screenshot functionality
- Custom view controller example

## 🛠️ Configuration Options

### In CharadesApp.swift
```swift
// Control allowed orientations
AppDelegate.orientationLock = .all  // or .portrait, .landscape
```

### In ContentView.swift
```swift
// Disable scroll bouncing
webView.scrollView.bounces = false

// Enable/disable scroll indicators
webView.scrollView.showsVerticalScrollIndicator = false
```

### In Info.plist
```xml
<!-- Supported orientations -->
<key>UISupportedInterfaceOrientations</key>
<array>
    <string>UIInterfaceOrientationPortrait</string>
    <string>UIInterfaceOrientationLandscapeLeft</string>
    <string>UIInterfaceOrientationLandscapeRight</string>
</array>
```

## 🎮 Testing

### On Simulator
```bash
# Run in Xcode
⌘R

# Select simulator from top dropdown
# Device → iPhone 14, iPhone SE, iPad, etc.
```

### On Real Device
```bash
# Connect iPhone via USB
# Trust this computer when prompted
# Select device in Xcode
# Click Run (⌘R)
```

### Debug Console
```
Safari → Develop → Charades (Simulator/Device)
# View console logs, run JavaScript commands
```

## 🔗 JavaScript Bridge (Optional)

If using OptionalEnhancements.swift, communicate from JavaScript:

```javascript
// In index.html, add this function
function callNative(action, data = {}) {
    window.webkit.messageHandlers.nativeApp.postMessage({
        action: action,
        ...data
    });
}

// Examples:
callNative('vibrate');                    // Device vibrates
callNative('share', { text: 'Score: 20' }); // Share dialog
callNative('log', { message: 'Game started' }); // Console log
```

## 🐛 Troubleshooting

### WebView blank after build
**Problem:** HTML file not loading
**Solution:**
1. Check Build Phases → Copy Bundle Resources
2. Verify index.html is in the list
3. If missing: Select project → Charades target → Build Phases → Add Files

### App crashes on launch
**Problem:** Swift compilation error
**Solution:**
1. Check Console (⌘⇧C) for error messages
2. Verify @main decorator in CharadesApp.swift
3. Ensure all imports are present (import SwiftUI, import WebKit)

### Orientation won't change
**Problem:** App stuck in portrait or landscape
**Solution:**
1. In AppDelegate, change: `AppDelegate.orientationLock = .all`
2. Device settings: Settings → Display & Brightness → check Auto-Rotate
3. Swipe up → lock icon should be unlocked

### Tilt controls don't work
**Problem:** Device motion not detected
**Solution:**
1. Check iOS Settings → Privacy → Motion & Fitness
2. App should have permission enabled
3. Grant permission when app first requests it
4. Simulator: Device → Shake to trigger haptics (for testing)

### Sounds don't play
**Problem:** Audio not working
**Solution:**
1. Check device mute switch is OFF
2. In ContentView.swift, verify:
   ```swift
   config.mediaTypesRequiringUserActionForPlayback = []
   ```
3. Check volume is not at 0
4. Try in Safari first to isolate issues

## 📦 Building for App Store

### Prerequisites
- Apple Developer Account ($99/year)
- Signing certificates configured

### Steps
1. Product → Scheme → Edit Scheme
2. Set Build Configuration to Release
3. Product → Archive
4. Organizer window opens
5. Click "Distribute App"
6. Choose "App Store Connect"
7. Follow prompts to upload

### Pre-Submission Checklist
- [ ] App icon added (see Assets.xcassets)
- [ ] App version updated in Info.plist
- [ ] Minimum iOS version set (iOS 14+)
- [ ] All features tested on real device
- [ ] Privacy policy URL added
- [ ] Screenshots prepared for App Store

## 💡 Pro Tips

### Development Workflow
1. Keep index.html in web server (port 8000)
2. Edit HTML/CSS/JS → save
3. Reload in Safari Dev Tools
4. Changes appear instantly (no rebuild needed)
5. When ready: Copy to Xcode project → build app

### Performance Optimization
```swift
// Disable unnecessary features
config.preferences.isElementFullscreenEnabled = true
config.preferences.isFraudulentWebsiteWarningEnabled = false
```

### Custom Styling for App
```javascript
// In index.html, detect if running in native app
if (window.webkit) {
    document.body.classList.add('native-app');
}
```

### Dark Mode Support
App respects system dark mode. In ContentView.swift:
```swift
@Environment(\.colorScheme) var colorScheme
```

## 📚 Resources

- [SwiftUI Documentation](https://developer.apple.com/xcode/swiftui/)
- [WebKit API Reference](https://developer.apple.com/documentation/webkit)
- [Xcode Help](https://help.apple.com/xcode/)
- [App Store Review Guidelines](https://developer.apple.com/app-store/review/guidelines/)

## 🎓 Learning Path

1. **Beginner:** Use ContentView.swift + CharadesApp.swift
2. **Intermediate:** Add WebViewDelegate.swift for event handling
3. **Advanced:** Use OptionalEnhancements.swift for native features
4. **Expert:** Build custom Swift UI alongside WebView

## 📞 Support

If you encounter issues:

1. **Check the Guide:** SWIFT_SETUP_GUIDE.md has detailed troubleshooting
2. **Review Code Comments:** Each file has inline documentation
3. **Check Console:** ⌘⇧C in Xcode for error messages
4. **Test in Safari:** Load index.html in Safari to verify web app
5. **Isolate Issue:** Test features one at a time

## ✨ What's Next?

- [ ] Get app running on simulator
- [ ] Test on real iPhone
- [ ] Add app icon
- [ ] Add custom launch screen
- [ ] Publish to App Store
- [ ] Add push notifications (optional)
- [ ] Add in-app purchases (optional)

## 📝 Notes

- This is a WebView wrapper, not a rewrite
- All game logic stays in HTML/JavaScript
- Swift handles native UI and device features
- Easy to update: just replace index.html
- Can be published to App Store as-is

---

**Happy coding!** 🎭

Questions? Check SWIFT_SETUP_GUIDE.md for detailed instructions.
