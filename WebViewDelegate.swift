import WebKit
import AVFoundation

class WebViewDelegate: NSObject, WKNavigationDelegate, WKUIDelegate {

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

    // Handle fullscreen video requests
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

        // Enable fullscreen support
        webView.evaluateJavaScript("""
            document.body.style.webkitUserSelect = 'none';
            """)
    }

    // Handle page load errors
    func webView(
        _ webView: WKWebView,
        didFailProvisionalNavigation navigation: WKNavigation!,
        withError error: Error
    ) {
        print("❌ Failed to load page: \\(error.localizedDescription)")
    }
}
