import SwiftUI
import AVFoundation
import MediaPlayer

struct ContentView: View {
    @State private var gameState = "menu" // menu, playing, gameOver
    @State private var selectedCategory: String?
    @State private var currentWord: String = ""
    @State private var score = 0
    @State private var skipped = 0
    @State private var timeLeft = 60
    @State private var timer: Timer?
    @State private var soundEnabled = true
    @State private var actionFeedback: String? = nil

    let categories = [
        "Movies": ["Avatar", "Inception", "Titanic", "Forrest Gump", "The Matrix", "Interstellar", "Gladiator", "The Dark Knight", "Pulp Fiction", "Fight Club"],
        "Animals": ["Lion", "Elephant", "Penguin", "Dolphin", "Cheetah", "Giraffe", "Eagle", "Octopus", "Tiger", "Panda"],
        "Sports": ["Basketball", "Football", "Tennis", "Swimming", "Gymnastics", "Skateboarding", "Surfing", "Boxing", "Hockey", "Golf"],
        "Celebrities": ["Beyoncé", "Drake", "Taylor Swift", "Tom Cruise", "Oprah", "Elon Musk", "Rihanna", "Brad Pitt", "Dwayne Johnson", "Meryl Streep"],
        "Foods": ["Pizza", "Sushi", "Burger", "Pasta", "Tacos", "Spaghetti", "Steak", "Donut", "Ice Cream", "Chicken"],
        "Jobs": ["Doctor", "Teacher", "Chef", "Pilot", "Astronaut", "Engineer", "Artist", "Musician", "Firefighter", "Dancer"],
    ]

    var body: some View {
        ZStack {
            // Background
            LinearGradient(gradient: Gradient(colors: [Color(red: 0.05, green: 0.28, blue: 0.64), Color(red: 0.12, green: 0.53, blue: 0.90)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack {
                if gameState == "menu" {
                    menuView
                } else if gameState == "playing" {
                    gameView
                } else if gameState == "gameOver" {
                    gameOverView
                }
            }
        }
        .onAppear {
            setupVolumeButtonDetection()
        }
    }

    // MARK: - Menu View
    var menuView: some View {
        VStack(spacing: 20) {
            Text("CHARADES")
                .font(.system(size: 48, weight: .bold))
                .foregroundColor(.white)

            Spacer()

            Text("Select a Category")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.white)

            ScrollView {
                VStack(spacing: 12) {
                    ForEach(Array(categories.keys.sorted()), id: \.self) { category in
                        Button(action: {
                            selectedCategory = category
                            startGame()
                        }) {
                            Text(category)
                                .font(.system(size: 18, weight: .semibold))
                                .frame(maxWidth: .infinity)
                                .padding(15)
                                .background(Color.white.opacity(0.9))
                                .foregroundColor(.blue)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding()
            }
        }
        .padding()
    }

    // MARK: - Game View
    var gameView: some View {
        VStack(spacing: 20) {
            // Header
            HStack {
                VStack(alignment: .leading) {
                    Text("Score")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                    Text("\(score)")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                }

                Spacer()

                VStack(alignment: .center) {
                    Text("Time")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                    Text("\(timeLeft)s")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(timeLeft < 10 ? .red : .white)
                }

                Spacer()

                VStack(alignment: .trailing) {
                    Text("Skipped")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                    Text("\(skipped)")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                }
            }
            .padding()
            .background(Color.white.opacity(0.1))
            .cornerRadius(10)

            Spacer()

            // Word Display
            VStack(spacing: 20) {
                Text(currentWord)
                    .font(.system(size: 52, weight: .bold))
                    .foregroundColor(.white)
                    .padding(30)
                    .frame(maxWidth: .infinity)
                    .background(Color.white.opacity(0.15))
                    .cornerRadius(15)

                Text("Use Volume Buttons:")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white.opacity(0.8))

                HStack(spacing: 12) {
                    Button(action: handleSkip) {
                        VStack(spacing: 8) {
                            Image(systemName: "speaker.slash")
                                .font(.system(size: 24))
                            Text("Skip")
                                .font(.system(size: 12, weight: .semibold))
                        }
                        .frame(maxWidth: .infinity)
                        .padding(15)
                        .background(Color.yellow.opacity(0.8))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                    }

                    Button(action: handleCorrect) {
                        VStack(spacing: 8) {
                            Image(systemName: "speaker.wave.3")
                                .font(.system(size: 24))
                            Text("Correct")
                                .font(.system(size: 12, weight: .semibold))
                        }
                        .frame(maxWidth: .infinity)
                        .padding(15)
                        .background(Color.green.opacity(0.8))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                    }
                }
            }

            Spacer()

            Button(action: endGame) {
                Text("End Game")
                    .font(.system(size: 16, weight: .semibold))
                    .frame(maxWidth: .infinity)
                    .padding(12)
                    .background(Color.red.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .scaleEffect(actionFeedback == "correct" ? 1.1 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: actionFeedback)
    }

    // MARK: - Game Over View
    var gameOverView: some View {
        VStack(spacing: 30) {
            Text("Game Over!")
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.white)

            VStack(spacing: 15) {
                HStack {
                    Text("Final Score:")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white.opacity(0.8))
                    Spacer()
                    Text("\(score)")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                }

                HStack {
                    Text("Words Skipped:")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white.opacity(0.8))
                    Spacer()
                    Text("\(skipped)")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                }
            }
            .padding(20)
            .background(Color.white.opacity(0.1))
            .cornerRadius(15)

            Spacer()

            Button(action: { gameState = "menu"; resetGame() }) {
                Text("Play Again")
                    .font(.system(size: 18, weight: .semibold))
                    .frame(maxWidth: .infinity)
                    .padding(15)
                    .background(Color.white)
                    .foregroundColor(.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
    }

    // MARK: - Game Logic
    func startGame() {
        gameState = "playing"
        score = 0
        skipped = 0
        timeLeft = 60
        getNextWord()
        startTimer()
    }

    func getNextWord() {
        guard let category = selectedCategory, let words = categories[category] else { return }
        currentWord = words.randomElement() ?? "No words"
    }

    func handleCorrect() {
        score += 1
        playSound(frequency: 800)
        actionFeedback = "correct"
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            actionFeedback = nil
            getNextWord()
        }
    }

    func handleSkip() {
        skipped += 1
        playSound(frequency: 400)
        actionFeedback = "skip"
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            actionFeedback = nil
            getNextWord()
        }
    }

    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            timeLeft -= 1
            if timeLeft <= 0 {
                endGame()
            }
        }
    }

    func endGame() {
        timer?.invalidate()
        gameState = "gameOver"
    }

    func resetGame() {
        selectedCategory = nil
        currentWord = ""
        score = 0
        skipped = 0
        timeLeft = 60
    }

    // MARK: - Volume Button Detection
    func setupVolumeButtonDetection() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playback, mode: .default, options: [])
            try audioSession.setActive(true)
        } catch {
            print("Error setting up audio session: \(error)")
        }

        // Setup media controls for volume button detection
        setupMediaRemoteCommands()
    }

    func setupMediaRemoteCommands() {
        let commandCenter = MPRemoteCommandCenter.shared()

        // Volume Down = Correct
        commandCenter.nextTrackCommand.addTarget { _ in
            handleCorrect()
            return .success
        }

        // Volume Up = Skip
        commandCenter.previousTrackCommand.addTarget { _ in
            handleSkip()
            return .success
        }
    }

    // MARK: - Sound
    func playSound(frequency: Double) {
        guard soundEnabled else { return }

        let audioEngine = AVAudioEngine()
        let audioSession = AVAudioSession.sharedInstance()

        do {
            try audioSession.setCategory(.playback, mode: .default, options: [])
            try audioSession.setActive(true)

            let output = audioEngine.outputNode
            let mixer = AVAudioMixerNode()
            audioEngine.attach(mixer)

            if !audioEngine.isRunning {
                try audioEngine.start()
            }
        } catch {
            print("Audio setup failed: \(error)")
        }
    }
}

#Preview {
    ContentView()
}
