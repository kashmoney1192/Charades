import SwiftUI

@main
struct CharadesApp: App {
    // Prevent device rotation locking (allow all orientations)
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    // Allow all interface orientations
                    AppDelegate.orientationLock = .all
                }
        }
    }
}

// App Delegate for controlling orientation
class AppDelegate: NSObject, UIApplicationDelegate {
    static var orientationLock = UIInterfaceOrientationMask.all

    func application(
        _ application: UIApplication,
        supportedInterfaceOrientationsFor window: UIWindow?
    ) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
}

// Scene Delegate configuration
class SceneDelegate: NSObject, UIWindowSceneDelegate {
    func windowScene(
        _ windowScene: UIWindowScene,
        didUpdate previousCoordinateSpace: UICoordinateSpace,
        interfaceOrientationChanged newInterfaceOrientation: UIInterfaceOrientation
    ) {
        // Handle orientation changes if needed
    }
}
