# ⚡ Swift Files - Quick Reference Card

## 🎯 What You Need to Copy into Xcode

### Three Required Files

```
✅ CharadesApp.swift      (~45 lines)
✅ ContentView.swift      (~70 lines)
✅ WebViewDelegate.swift  (~65 lines)
```

### One Web File

```
✅ index.html             (your existing game file)
```

---

## 🚀 Xcode Setup in 5 Minutes

### 1. Create Project
```
Xcode → File → New → Project
iOS → App
Product Name: Charades
Interface: SwiftUI
```

### 2. Add Swift Files
```
File → New → File → Swift File
Name: ContentView.swift
Copy-paste content from ContentView.swift
Repeat for other files
```

### 3. Add HTML
```
Drag index.html into Xcode
Check "Copy items if needed"
Check "Charades" target
Click Add
```

### 4. Verify Build Phases
```
Select Project → Charades target
Build Phases tab
Expand "Copy Bundle Resources"
Verify index.html is there
```

### 5. Build & Run
```
⌘B  (Build)
⌘R  (Run on Simulator)
```

---

## 📄 File Purposes

| File | Size | Purpose | Required |
|------|------|---------|----------|
| CharadesApp.swift | 45 lines | App entry point, orientation | ✅ YES |
| ContentView.swift | 70 lines | WebView UI, load HTML | ✅ YES |
| WebViewDelegate.swift | 65 lines | Event handling, errors | ✅ YES |
| OptionalEnhancements.swift | 250 lines | Haptics, sharing (optional) | ⭐ NO |
| index.html | Your file | The game itself | ✅ YES |

---

## 🔧 Code Snippets You Need

### Load HTML in ContentView.swift
```swift
if let htmlPath = Bundle.main.path(forResource: "index", ofType: "html") {
    let htmlURL = URL(fileURLWithPath: htmlPath)
    webView.loadFileURL(htmlURL, allowingReadAccessTo: htmlURL)
}
```

### App Entry Point in CharadesApp.swift
```swift
@main
struct CharadesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

### WebView Config in ContentView.swift
```swift
config.mediaTypesRequiringUserActionForPlayback = []
// ^ Enables sound effects without user tap
```

---

## 🎮 Testing Checklist

- [ ] App builds without errors (⌘B)
- [ ] App runs on simulator (⌘R)
- [ ] Charades game loads
- [ ] Categories display properly
- [ ] Can select a category
- [ ] Game starts
- [ ] Tilt controls work (if supported)
- [ ] Audio plays
- [ ] Orientation changes work
- [ ] Full-screen button works

---

## ❌ Common Errors & Fixes

### "index.html not found"
→ Add to Build Phases → Copy Bundle Resources

### "Type ContentView not found"
→ File → Add Files → Select ContentView.swift

### "WebView is blank"
→ Check Console (⌘⇧C) for errors
→ Verify index.html in Build Phases

### "App won't build"
→ Check for Swift syntax errors
→ Verify all imports: `import SwiftUI`, `import WebKit`
→ Ensure @main decorator is present

### "Tilt doesn't work"
→ Settings → Privacy → Motion & Fitness
→ Grant app permission

### "Sound won't play"
→ Device mute switch OFF
→ Check mediaTypesRequiringUserActionForPlayback = []

---

## 🎯 Three Setup Paths

### Path A: Minimal (5 minutes)
1. Copy CharadesApp.swift
2. Copy ContentView.swift
3. Copy WebViewDelegate.swift
4. Add index.html
5. Run

### Path B: Full Setup (15 minutes)
1. Follow Path A
2. Add app icon
3. Configure Info.plist
4. Test on device
5. Fix issues

### Path C: App Store Ready (1-2 hours)
1. Follow Path B
2. Add launch screen
3. Add screenshots
4. Configure signing
5. Submit to App Store

---

## 📱 Device Testing

### Simulator Only
```
⌘R in Xcode
Select iPhone 14 from dropdown
Watch app load in simulator
```

### Real Device
```
Connect iPhone via USB
Trust "This Computer"
Select device in Xcode
⌘R
```

### Debug Console
```
Safari → Develop → Charades
View logs and run JS commands
```

---

## 🔗 File Locations in Your Project

```
After setup in Xcode:

Charades/
├── CharadesApp.swift          ← Copy from repo
├── ContentView.swift          ← Copy from repo
├── WebViewDelegate.swift      ← Copy from repo
├── index.html                 ← Copy your HTML file
├── Assets.xcassets            ← Default (for icon)
└── Preview Content/           ← Default (for preview)
```

---

## ⚙️ Configuration Keywords

Find these in the code to customize:

| Keyword | Location | What It Does |
|---------|----------|--------------|
| `htmlPath` | ContentView.swift | File to load |
| `AppDelegate.orientationLock` | CharadesApp.swift | Allowed rotations |
| `config.mediaTypesRequiringUserActionForPlayback` | ContentView.swift | Audio behavior |
| `showsVerticalScrollIndicator` | ContentView.swift | Scroll bar visibility |
| `bounces` | ContentView.swift | Scroll bounce effect |

---

## 🚨 Before You Deploy

```
☐ Test all game features
☐ Test on real iPhone
☐ Test portrait + landscape
☐ Test tilt controls
☐ Test sounds
☐ Test fullscreen
☐ Add app icon
☐ Update version number
☐ Write privacy policy (if needed)
☐ Create App Store screenshots
☐ Configure signing team
```

---

## 📞 Quick Troubleshooting

**App launches but shows white screen?**
→ index.html not in Build Phases

**Game loads but has no content?**
→ Check Browser Developer Tools (Safari)
→ Look for console errors

**Buttons don't respond?**
→ Verify pointerEvents not disabled
→ Check z-index layers

**Orientation stuck?**
→ Device Settings → Control Center
→ Unlock orientation lock icon

**Can't build at all?**
→ Check Swift syntax
→ Verify file is in target membership
→ Clean build folder (⇧⌘K)

---

## 🎓 Next Steps

1. **Now:** Copy files, build, run
2. **Then:** Test on simulator
3. **Then:** Fix any issues
4. **Then:** Test on real iPhone
5. **Then:** Add app icon & publish

---

## 📚 Where to Learn More

- **Stuck on setup?** → See SWIFT_SETUP_GUIDE.md
- **Need Xcode help?** → See XCODE_SETUP.md
- **Want advanced features?** → See OptionalEnhancements.swift
- **Full details?** → See SWIFT_README.md

---

## ✅ Success Checklist

You're done when you see:

- [ ] App builds (⌘B shows no errors)
- [ ] App runs (⌘R launches simulator)
- [ ] Game loads with blue gradient background
- [ ] Categories appear
- [ ] Fullscreen button works
- [ ] Can play a game
- [ ] Orientation changes work

**🎉 Congratulations! You have a native iOS Charades app!**

---

**Questions?** Check the detailed guides:
- SWIFT_SETUP_GUIDE.md (step-by-step)
- XCODE_SETUP.md (quick reference)
- SWIFT_README.md (comprehensive)
