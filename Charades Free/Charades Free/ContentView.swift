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
    @State private var searchText = ""

    let categories: [String: [String]] = [
        "🎬 Movies": ["The Shawshank Redemption", "Inception", "The Dark Knight", "Forrest Gump", "Pulp Fiction", "The Matrix", "Titanic", "Avatar", "Interstellar", "Parasite", "Avengers Endgame", "Joker", "The Quiet Place", "Knives Out", "Dune", "Back to the Future", "Jurassic Park", "E.T.", "Home Alone", "The Godfather", "Gladiator", "The Lion King", "Frozen", "Toy Story", "Spider-Man", "Batman Begins", "The Avengers", "Iron Man", "Captain America", "Thor", "Black Panther", "Wonder Woman", "Aquaman", "The Flash", "Godzilla", "King Kong", "Jaws"],
        "👻 Horror Movies": ["The Exorcist", "The Shining", "Halloween", "Friday the 13th", "A Nightmare on Elm Street", "Scream", "The Ring", "Saw", "Jaws", "Alien", "Aliens", "Poltergeist", "The Sixth Sense", "The Conjuring", "Insidious", "Sinister", "The Babadook", "Hereditary", "Midsommar", "Get Out", "Us", "Candyman", "It Follows", "The Witch"],
        "🎃 Halloween": ["Trick or Treat", "Jack o Lantern", "Pumpkin", "Candy", "Costume", "Ghost", "Skeleton", "Witch", "Vampire", "Zombie", "Mummy", "Frankenstein", "Werewolf", "Devil", "Demon", "Scarecrow", "Black Cat", "Bat", "Spider", "Haunted House", "Cemetery", "Tombstone"],
        "🦁 Animals": ["Lion", "Tiger", "Elephant", "Giraffe", "Penguin", "Eagle", "Dolphin", "Octopus", "Kangaroo", "Sloth", "Flamingo", "Chameleon", "Porcupine", "Hedgehog", "Koala", "Panda", "Cheetah", "Rhinoceros", "Zebra", "Peacock", "Butterfly", "Bee", "Ant", "Spider", "Scorpion", "Snake", "Crocodile", "Alligator", "Turtle", "Shark", "Whale", "Seal"],
        "⭐ Celebrities": ["Taylor Swift", "Elon Musk", "Dwayne Johnson", "Oprah Winfrey", "Beyoncé", "Leonardo DiCaprio", "Scarlett Johansson", "Tom Cruise", "Cristiano Ronaldo", "Lionel Messi", "Billie Eilish", "The Rock", "Kim Kardashian", "Kanye West", "Ariana Grande", "Harry Styles", "Zendaya", "Timothée Chalamet", "Margot Robbie", "Brad Pitt"],
        "📺 TV Shows": ["The Office", "Friends", "Breaking Bad", "Game of Thrones", "The Crown", "Stranger Things", "The Mandalorian", "Succession", "True Detective", "Mindhunter", "Sherlock", "Doctor Who", "The Expanse", "The Witcher", "Peaky Blinders", "Westworld", "Dark", "Chernobyl", "The Marvelous Mrs. Maisel", "The Last of Us"],
        "🏆 Sports": ["Basketball", "Football", "Tennis", "Swimming", "Gymnastics", "Skateboarding", "Surfing", "Boxing", "Hockey", "Golf", "Baseball", "Cricket", "Rugby", "Volleyball", "Badminton", "Table Tennis", "Ice Skating", "Skiing", "Snowboarding", "Lacrosse"],
        "🍕 Food": ["Pizza", "Sushi", "Burger", "Pasta", "Tacos", "Spaghetti", "Steak", "Donut", "Ice Cream", "Chicken", "Chocolate", "Cookies", "Cake", "Sandwich", "Fries", "Hot Dog", "Salad", "Soup", "Rice", "Bread"],
        "🎵 Music Artists": ["Taylor Swift", "The Weeknd", "Drake", "Rihanna", "Lady Gaga", "Beyoncé", "Eminem", "Jay-Z", "Post Malone", "Billie Eilish", "Ariana Grande", "Ed Sheeran", "Coldplay", "Shakira", "Britney Spears", "Madonna", "Kanye West", "Travis Scott", "Khalid", "Dua Lipa"],
        "🎮 Video Games": ["Super Mario Bros", "The Legend of Zelda", "Minecraft", "Fortnite", "Call of Duty", "Grand Theft Auto", "Halo", "Elden Ring", "Dark Souls", "The Witcher 3", "Cyberpunk 2077", "Skyrim", "Final Fantasy VII", "Metal Gear Solid", "Fallout 4", "Red Dead Redemption", "Overwatch", "League of Legends", "Dota 2", "Counter-Strike"],
        "🌍 Countries": ["France", "Japan", "Brazil", "Mexico", "Germany", "Spain", "Italy", "Canada", "Australia", "India", "China", "Russia", "Egypt", "Thailand", "Greece", "Switzerland", "Netherlands", "Singapore", "New Zealand", "Iceland"],
        "🏢 Jobs": ["Doctor", "Teacher", "Chef", "Pilot", "Astronaut", "Engineer", "Artist", "Musician", "Firefighter", "Dancer", "Lawyer", "Nurse", "Architect", "Scientist", "Electrician", "Plumber", "Carpenter", "Mechanic", "Police Officer", "Programmer"],
    ]

    var body: some View {
        ZStack {
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
                    .lineLimit(3)

                Text("Use Volume Buttons or Tap Below:")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white.opacity(0.8))

                HStack(spacing: 12) {
                    Button(action: handleSkip) {
                        VStack(spacing: 8) {
                            Image(systemName: "speaker.slash")
                                .font(.system(size: 24))
                            Text("Skip (Vol +)")
                                .font(.system(size: 11, weight: .semibold))
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
                            Text("Correct (Vol -)")
                                .font(.system(size: 11, weight: .semibold))
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
        .scaleEffect(actionFeedback == "correct" ? 1.05 : 1.0)
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
            try audioSession.setCategory(.playback, mode: .default, options: [.duckOthers])
            try audioSession.setActive(true)
        } catch {
            print("Error setting up audio session: \(error)")
        }

        setupMediaRemoteCommands()
    }

    func setupMediaRemoteCommands() {
        let commandCenter = MPRemoteCommandCenter.shared()

        commandCenter.nextTrackCommand.addTarget { _ in
            self.handleSkip()
            return .success
        }

        commandCenter.previousTrackCommand.addTarget { _ in
            self.handleCorrect()
            return .success
        }
    }

    // MARK: - Sound
    func playSound(frequency: Double) {
        guard soundEnabled else { return }

        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playback, mode: .default, options: [.duckOthers])
            try audioSession.setActive(true)
        } catch {
            print("Audio setup failed: \(error)")
        }
    }
}

#Preview {
    ContentView()
}
