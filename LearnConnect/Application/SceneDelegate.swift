//
//  SceneDelegate.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 21.11.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        if !isInternetAvailable() && isUserLoggedIn() { // Show the offline mode screen if the user is logged in but no internet is available
            print("Offline mode activated")
            let downloadViewController = DownloadViewController(viewModel: DownloadViewModel())
            let navigationController = MainNavigationController(rootViewController: downloadViewController)
            window.rootViewController = navigationController
        }else if isUserLoggedIn() { // Show the MainTabBarController if the user is logged in and internet is available
            print("User logged in, showing MainTabBarController")
            let mainTabBarController = MainTabBarController(userEmail: UserDefaults.standard.string(forKey: "loggedInUserEmail"))
            let navigationController = MainNavigationController(rootViewController: mainTabBarController)
            window.rootViewController = navigationController
        }else { // Show the intro screen if the user is not logged in
            print("User not logged in, showing IntroViewController")
            let introViewController = IntroViewController(viewModel: IntroViewModel())
            let navigationController = MainNavigationController(rootViewController: introViewController)
            window.rootViewController = navigationController
        }

        self.window = window
        window.makeKeyAndVisible()
    }
    
    // MARK: - Helper Methods
    
    /// - Returns: `true` if the user is logged in, otherwise `false`.
    private func isUserLoggedIn() -> Bool {
        return UserDefaults.standard.string(forKey: "loggedInUserEmail") != nil
    }
    
    /// - Returns: `true` if the internet is available, otherwise `false
    private func isInternetAvailable() -> Bool {
        let connection = Reachability.currentConnection()
        return connection != .unavailable
    }
}
