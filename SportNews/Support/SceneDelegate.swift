//
//  SceneDelegate.swift
//  SportNews
//
//  Created by Hakan Türkmen on 23.04.2024.
//

import UIKit
import AppTrackingTransparency
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = createTabBar()
        self.window = window
        window.makeKeyAndVisible()
    }
    
    func createTabBar() -> UITabBarController
    {
        let tabBar = UITabBarController()
        tabBar.viewControllers = [createNewsVC(),createTriviaVC(),createFeedVC(),createGuessVC(),createHangmanVC()]
        
        return tabBar
    }
    
    func createFeedVC() -> UINavigationController
    {
        let nav = FeedVC()
        nav.title = "Countdown"
        nav.tabBarItem = UITabBarItem(title: "Countdown", image: UIImage(systemName: "clock.fill"), tag: 1)
        nav.tabBarController?.title = "News"
        return UINavigationController(rootViewController: nav)
    }
    
    func createTriviaVC() -> UINavigationController
    {
        let nav = TriviaVC()
        nav.title = "Trivia"
        nav.tabBarItem = UITabBarItem(title: "Trivia", image: UIImage(systemName: "questionmark.ar"), tag: 0)
        nav.tabBarController?.title = "Trivia"
        return UINavigationController(rootViewController: nav)
    }
    
    func createNewsVC() -> UINavigationController
    {
        let nav = NewsVC()
        nav.title = "News"
        nav.tabBarItem = UITabBarItem(title: "News", image: UIImage(systemName: "newspaper"), tag: 0)
        nav.tabBarController?.title = "News"
        return UINavigationController(rootViewController: nav)
    }
    
    
   
    func createHangmanVC() -> UINavigationController
    {
        let nav = HangmanVC()
        nav.title = "Hangman"
        nav.tabBarItem = UITabBarItem(title: "Hangman", image: UIImage(systemName: "figure.stand"), tag: 2)
        nav.tabBarController?.title = "Hangman"
        return UINavigationController(rootViewController: nav)
    }
    
    
    
    func createGuessVC() -> UINavigationController
    {
        let nav = GuessPlayerVC()
        nav.title = "Guess"
        nav.tabBarItem = UITabBarItem(title: "Guess", image: UIImage(systemName:  "questionmark.circle.fill"), tag: 3)
        nav.tabBarController?.title = "Guess"
        return UINavigationController(rootViewController: nav)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        if #available(iOS 14, *) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1 ){
                ATTrackingManager.requestTrackingAuthorization { (status) in
                  //print("IDFA STATUS: \(status.rawValue)")
                }
            }
          
        }
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

