//
//  ContentView.swift
//  Charades Free
//
//  Created by Aakash Goradia on 11/7/25.
//

import SwiftUI
import WebKit

struct ContentView: View {
    var body: some View {
        ZStack {
            // Background gradient matching the web app
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.05, green: 0.28, blue: 0.63),    // #0D47A1
                    Color(red: 0.12, green: 0.53, blue: 0.9),     // #1E88E5
                    Color(red: 0.0, green: 0.74, blue: 0.77)      // #00BCD4
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            // WebView for the Charades game
            WebViewContainer()
                .ignoresSafeArea()
        }
    }
}

// WebView wrapper using UIViewRepresentable
struct WebViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()

        // Enable JavaScript and fullscreen support
        config.allowsInlineMediaPlayback = true
        config.allowsAirPlayForMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []

        // Allow JavaScript
        config.defaultWebpagePreferences.allowsContentJavaScript = true

        let webView = WKWebView(frame: .zero, configuration: config)
        webView.scrollView.bounces = false
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsHorizontalScrollIndicator = false

        // Set navigation delegate
        webView.navigationDelegate = context.coordinator

        // Load the HTML file from the app bundle
        if let htmlPath = Bundle.main.path(forResource: "index", ofType: "html") {
            let htmlURL = URL(fileURLWithPath: htmlPath)
            webView.loadFileURL(htmlURL, allowingReadAccessTo: htmlURL)
        } else {
            // Fallback: load from GitHub Pages if HTML not in bundle
            if let url = URL(string: "https://kashmoney1192.github.io/Charades/") {
                webView.load(URLRequest(url: url))
            }
        }

        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        // Update logic here if needed
    }

    func makeCoordinator() -> WebViewDelegate {
        WebViewDelegate()
    }
}

#Preview {
    ContentView()
}
