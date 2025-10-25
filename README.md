# 🎭 Charades Game

A mobile-friendly web app for playing Charades with tilt controls, just like the real Heads Up! game.

## Features

✨ **Mobile-First Design**
- Fully responsive design optimized for phones and tablets
- Works in portrait and landscape mode
- Fullscreen toggle for immersive gameplay

🎮 **Tilt Controls** (Like Real Charades)
- Uses DeviceOrientation API for phone tilt detection
- Hold phone to your forehead during gameplay
- **Tilt Down ↓** = Correct answer (green flash + high pitch sound)
- **Tilt Up ↑** = Skip word (red flash + low pitch sound)
- 1-second cooldown between tilts to prevent accidental triggers
- Works on iPhone and Android

📁 **Multiple Categories**
- 🎬 Movies
- 🦁 Animals
- ⭐ Celebrities
- ⚽ Sports
- 💼 Jobs
- 🎭 Actions

⏱️ **Game Features**
- 60-second timer with visual warning animation
- Score tracker (correct, skipped, total)
- Random word/phrase selection per category
- Next word button for manual control
- End game button to stop anytime

🔊 **Audio & Visual Feedback**
- Sound effects for correct (1200 Hz) and skip (600 Hz)
- Flash animations (green for correct, red for skip)
- Responsive UI that works on all screen sizes

## How to Play

1. **Select a Category** - Choose from 6 different word categories
2. **Start the Game** - 60 seconds on the clock
3. **Enable Tilt Controls** - Tap the 📱 button during gameplay
4. **Hold to Forehead** - One player holds the phone to their forehead
5. **Give Clues** - Other players describe the word without saying it
6. **Tilt to Answer**
   - Tilt DOWN ↓ if someone guesses correctly
   - Tilt UP ↑ to skip the word
7. **Beat Your Score** - Play again to beat your high score!

## Browser Compatibility

✅ **Tested on:**
- iPhone Safari (iOS 12+)
- iPhone Safari (iOS 13+)
- Android Chrome
- Android Firefox
- All modern mobile browsers

## Installation

### Play Online
Visit the live demo: [Charades Game](https://charades-game.netlify.app)

### Run Locally
1. Clone the repository:
```bash
git clone https://github.com/yourusername/Charades.git
cd Charades
```

2. Start a local server:
```bash
python3 -m http.server 8000
```

3. Open your browser to `http://localhost:8000`

## Technical Details

- **Framework**: React 18 (via CDN)
- **API**: DeviceOrientation Event API
- **Audio**: Web Audio API
- **Storage**: No backend needed - fully client-side
- **File Size**: Single HTML file (~1001 lines)

## Tilt Control Calibration

The app uses the phone's beta angle (pitch) to detect tilts:
- **Tilt Down**: Beta < -40° triggers correct answer
- **Tilt Up**: Beta > +40° triggers skip
- **Cooldown**: 1 second between actions

These thresholds are calibrated for holding the phone to your forehead.

## Future Enhancements

- [ ] Custom categories
- [ ] Multiplayer with score sync
- [ ] Difficulty levels
- [ ] More sound effects
- [ ] High score leaderboard
- [ ] Vibration feedback
- [ ] Dark mode

## License

MIT - Feel free to use and modify!

## Credits

Built with React and Web APIs for ultimate mobile gaming fun. 🎮

---

**Enjoy playing! 🎭**
