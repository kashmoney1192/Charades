import SwiftUI
import WebKit

// OPTIONAL: Advanced WebView with enhanced features
// Use this as an alternative to ContentView.swift for more features

struct AdvancedWebViewContainer: UIViewRepresentable {
    @Environment(\.colorScheme) var colorScheme

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()

        // JavaScript communication bridge
        config.userContentController.add(context.coordinator, name: "nativeApp")

        // Performance settings
        config.allowsInlineMediaPlayback = true
        config.allowsAirPlayForMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []
        config.defaultWebpagePreferences.allowsContentJavaScript = true

        let webView = WKWebView(frame: .zero, configuration: config)
        webView.scrollView.bounces = false
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsHorizontalScrollIndicator = false

        // Set navigation delegate
        webView.navigationDelegate = context.coordinator

        // Load HTML
        if let htmlPath = Bundle.main.path(forResource: "index", ofType: "html") {
            let htmlURL = URL(fileURLWithPath: htmlPath)
            webView.loadFileURL(htmlURL, allowingReadAccessTo: htmlURL)
        }

        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        // Update based on colorScheme changes if needed
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject, WKScriptMessageHandler, WKNavigationDelegate {
        // Handle messages from JavaScript
        func userContentController(
            _ userContentController: WKUserContentController,
            didReceive message: WKScriptMessage
        ) {
            if let body = message.body as? [String: Any] {
                if let action = body["action"] as? String {
                    handleNativeAction(action, data: body)
                }
            }
        }

        func handleNativeAction(_ action: String, data: [String: Any]) {
            switch action {
            case "vibrate":
                hapticFeedback()
            case "screenshot":
                takeScreenshot()
            case "share":
                if let text = data["text"] as? String {
                    shareScore(text)
                }
            case "log":
                if let message = data["message"] as? String {
                    print("📱 JavaScript: \(message)")
                }
            default:
                print("Unknown action: \(action)")
            }
        }

        func hapticFeedback() {
            let impact = UIImpactFeedbackGenerator(style: .medium)
            impact.impactOccurred()
        }

        func takeScreenshot() {
            // Trigger screenshot (implementation would go here)
            print("📸 Screenshot captured")
        }

        func shareScore(_ score: String) {
            // Share via native share sheet
            let items: [Any] = [score]
            let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)

            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let rootViewController = windowScene.windows.first?.rootViewController {
                rootViewController.present(ac, animated: true)
            }
        }

        // WKNavigationDelegate methods
        func webView(
            _ webView: WKWebView,
            didFinish navigation: WKNavigation!
        ) {
            print("✅ Game loaded successfully")

            // Inject CSS for native app improvements
            let css = """
            body { -webkit-user-select: none; }
            * { -webkit-touch-callout: none; }
            """

            webView.evaluateJavaScript("""
                const style = document.createElement('style');
                style.textContent = `\(css)`;
                document.head.appendChild(style);
                """)
        }

        func webView(
            _ webView: WKWebView,
            didFailProvisionalNavigation navigation: WKNavigation!,
            withError error: Error
        ) {
            print("❌ Load error: \(error.localizedDescription)")
        }
    }
}

// OPTIONAL: Custom View Controller for More Control
class CharadesViewController: UIViewController {
    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []

        webView = WKWebView(frame: view.bounds, configuration: config)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(webView)

        // Load HTML
        if let htmlPath = Bundle.main.path(forResource: "index", ofType: "html") {
            let htmlURL = URL(fileURLWithPath: htmlPath)
            webView.loadFileURL(htmlURL, allowingReadAccessTo: htmlURL)
        }

        // Hide status bar for immersive experience
        if #available(iOS 16, *) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// OPTIONAL: Combine View for Advanced Features
struct AdvancedContentView: View {
    @State private var showingSettings = false

    var body: some View {
        ZStack {
            // Background
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.05, green: 0.28, blue: 0.63),
                    Color(red: 0.12, green: 0.53, blue: 0.9),
                    Color(red: 0.0, green: 0.74, blue: 0.77)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            // WebView
            AdvancedWebViewContainer()
                .ignoresSafeArea()

            // Floating Settings Button (Optional)
            VStack {
                HStack {
                    Button(action: { showingSettings.toggle() }) {
                        Image(systemName: "gearshape.fill")
                            .font(.system(size: 18))
                            .foregroundColor(.white)
                            .padding(12)
                            .background(Color.black.opacity(0.3))
                            .clipShape(Circle())
                    }
                    .padding()

                    Spacer()
                }
                Spacer()
            }
        }
    }
}

// OPTIONAL: App Store Features Extension
extension CharadesApp {
    // Add this for app-specific features
    static func setupAppearance() {
        // Configure status bar
        UIApplication.shared.statusBarStyle = .lightContent

        // Configure navigation bar
        let navAppearance = UINavigationBarAppearance()
        navAppearance.backgroundEffect = UIBlurEffect(style: .dark)
        UINavigationBar.appearance().standardAppearance = navAppearance
    }
}

// OPTIONAL: JavaScript Bridge for Advanced Features
// Add this to your index.html to communicate with native code:
/*
function callNative(action, data = {}) {
    window.webkit.messageHandlers.nativeApp.postMessage({
        action: action,
        ...data
    });
}

// Usage examples:
callNative('vibrate');
callNative('share', { text: 'I scored 15 points in Charades!' });
callNative('log', { message: 'Game started' });
 */
