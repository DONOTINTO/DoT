//
//  SceneDelegate.swift
//  DoT
//
//  Created by 이중엽 on 3/7/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // MARK: Tab bar appearance
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = .clear
        tabBarAppearance.shadowColor = .clear
        // 스크롤 엣지가 닿았을 때 탭바 appearance settings
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        // 일반 탭바 appearance settings
        UITabBar.appearance().standardAppearance = tabBarAppearance
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        let dashboardVC = DashboardViewController()
        let dashboradNaviVC = UINavigationController(rootViewController: dashboardVC)
        
        let tripBookVC = TripBookViewController()
        let tripBookNaviVC = UINavigationController(rootViewController: tripBookVC)
        
        let tabVC = UITabBarController()
        tabVC.setViewControllers([dashboradNaviVC, tripBookNaviVC], animated: true)
        
        tabVC.tabBar.items?[0].image = UIImage(systemName: "house")?.withTintColor(.justGray, renderingMode: .alwaysOriginal)
        tabVC.tabBar.items?[0].selectedImage = UIImage(systemName: "house.fill")?.withTintColor(.blackWhite, renderingMode: .alwaysOriginal)
        tabVC.tabBar.items?[1].image = UIImage.plane.withTintColor(.justGray, renderingMode: .alwaysOriginal)
        tabVC.tabBar.items?[1].selectedImage = UIImage.plane.withTintColor(.blackWhite, renderingMode: .alwaysOriginal)
        
        self.window = window
        self.window?.rootViewController = tabVC
        self.window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
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

