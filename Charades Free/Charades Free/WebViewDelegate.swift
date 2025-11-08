//
//  WebViewDelegate.swift
//  Charades Free
//
//  Created by Aakash Goradia on 11/7/25.
//

import WebKit

class WebViewDelegate: NSObject, WKNavigationDelegate, WKUIDelegate {

    var webView: WKWebView?

    // Handle JavaScript alerts and prompts
    func webView(
        _ webView: WKWebView,
        runJavaScriptAlertPanelWithMessage message: String,
        initiatedByFrame frame: WKFrameInfo,
        completionHandler: @escaping () -> Void
    ) {
        let alert = UIAlertController(title: "Charades", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            completionHandler()
        })

        if let viewController = UIApplication.shared.windows.first?.rootViewController {
            viewController.present(alert, animated: true)
        }
    }

    // Handle fullscreen requests
    func webView(
        _ webView: WKWebView,
        commitPreviewingViewController previewingViewController: UIViewController
    ) {
        // Handle preview interactions if needed
    }

    // Handle navigation decisions
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
    ) {
        // Allow all navigation
        decisionHandler(.allow)
    }

    // Handle page load completion
    func webView(
        _ webView: WKWebView,
        didFinish navigation: WKNavigation!
    ) {
        print("✅ Charades game loaded successfully")
        self.webView = webView
        injectFixBackgroundCSS()
    }

    // Handle page load errors
    func webView(
        _ webView: WKWebView,
        didFailProvisionalNavigation navigation: WKNavigation!,
        withError error: Error
    ) {
        print("❌ Failed to load page: \(error.localizedDescription)")
    }

    // MARK: - CSS Injection for Background Display
    private func injectFixBackgroundCSS() {
        guard let webView = webView else { return }

        // Inject CSS fixes for background display during gameplay
        webView.evaluateJavaScript("""
            const style = document.createElement('style');
            style.textContent = `
                .container {
                    background-attachment: fixed !important;
                    background-size: cover !important;
                    background-position: center !important;
                    position: fixed !important;
                    top: 0 !important;
                    left: 0 !important;
                    right: 0 !important;
                    bottom: 0 !important;
                    width: 100vw !important;
                    height: 100vh !important;
                    padding: 0 !important;
                    margin: 0 !important;
                    overflow-y: scroll !important;
                }

                body {
                    background-attachment: fixed !important;
                    position: relative !important;
                }

                .game-screen {
                    background: transparent !important;
                    position: relative !important;
                    z-index: 10 !important;
                }

                .game-container {
                    background: transparent !important;
                }

                /* Ensure pseudo-elements (overlays) show properly */
                .container::before,
                .container::after {
                    position: fixed !important;
                    top: 0 !important;
                    left: 0 !important;
                    right: 0 !important;
                    bottom: 0 !important;
                    width: 100vw !important;
                    height: 100vh !important;
                }
            `;
            document.head.appendChild(style);
        """)
    }

}
