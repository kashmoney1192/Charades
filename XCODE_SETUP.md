# 📱 Quick Xcode Setup Instructions

## Copy & Paste This Into Xcode

### Step 1: Create New Project
```
File → New → Project
iOS → App
Product Name: Charades
Team: (Your Apple ID)
Organization Identifier: com.yourname.charades
Interface: SwiftUI
Lifecycle: SwiftUI App
```

### Step 2: Delete Default Files
- Delete the default ContentView.swift file
- Keep CharadesApp.swift (will be recreated)

### Step 3: Add Swift Files

Copy and paste the content from:
1. **CharadesApp.swift** - Replace the default one
2. **ContentView.swift** - Create new file
3. **WebViewDelegate.swift** - Create new file

**How to create new files:**
1. File → New → File
2. Choose "Swift File"
3. Name it (e.g., ContentView.swift)
4. Copy-paste the code
5. Make sure it's added to Charades target

### Step 4: Add index.html

1. Drag **index.html** into Xcode (left panel)
2. Check "Copy items if needed"
3. Check "Charades" target
4. Click Add

Then verify:
- Select project in navigator
- Select "Charades" target
- Go to "Build Phases" tab
- Expand "Copy Bundle Resources"
- Verify index.html is there

### Step 5: Update ContentView.swift

The ContentView.swift references index.html file. Make sure this code is in there:

```swift
if let htmlPath = Bundle.main.path(forResource: "index", ofType: "html") {
    let htmlURL = URL(fileURLWithPath: htmlPath)
    webView.loadFileURL(htmlURL, allowingReadAccessTo: htmlURL)
}
```

### Step 6: Build & Run

```
⌘B  - Build
⌘R  - Run
```

Select a simulator from the top of Xcode window.

## Expected Result

- App launches with gradient background
- Charades game loads from index.html
- All features work: categories, tilt controls, fullscreen, audio
- Orientation changes work (portrait ↔ landscape)

## If Something Doesn't Work

### "No such file or directory: index.html"
→ Go to Build Phases, add index.html to Copy Bundle Resources

### "Type ContentView not found"
→ Make sure ContentView.swift is in the Charades target (checkbox)

### WebView is blank
→ Check Console (⌘⇧C) for errors
→ Verify index.html is in Build Phases

### App crashes on launch
→ Check CharadesApp.swift has @main decorator
→ Verify all imports are correct

## Advanced: Using Local Server

For development, you can skip bundling and use a local server:

1. Start web server on port 8000:
   ```bash
   cd /Users/aakashgoradia/code/Charades
   python3 -m http.server 8000
   ```

2. The app will auto-detect and load from localhost

3. Edit index.html → reload browser → see changes instantly

## File Checklist

After setup, you should have:

```
Charades/
├── CharadesApp.swift          ✅
├── ContentView.swift          ✅
├── WebViewDelegate.swift      ✅
├── index.html                 ✅ (in Build Phases)
├── Assets.xcassets
└── Preview Content/
```

All .swift files should show ✅ in the file navigator with no red errors.

## Next: Customization

Once everything builds and runs:

1. **Add App Icon**
   - Assets.xcassets → AppIcon
   - Drag icon images
   - Requires 1x, 2x, 3x sizes

2. **Add Launch Screen**
   - File → New → Launch Screen Storyboard
   - Customize with your branding

3. **Update Info.plist**
   - Add app name, version, orientation settings

4. **Test on Real Device**
   - Connect iPhone via USB
   - Select device at top of Xcode
   - Build and run (⌘R)

## Support Resources

- **Swift Documentation**: https://developer.apple.com/swift/
- **SwiftUI Docs**: https://developer.apple.com/xcode/swiftui/
- **WebKit Docs**: https://developer.apple.com/documentation/webkit
- **Xcode Help**: Help menu in Xcode

---

**You're all set!** 🎉 Your Charades app is now a native iOS app that you can build, test, and ship to the App Store!
