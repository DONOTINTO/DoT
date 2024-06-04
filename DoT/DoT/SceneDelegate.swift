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
        
        // // MARK: Tab bar appearance
        // let tabBarAppearance = UITabBarAppearance()
        // tabBarAppearance.configureWithOpaqueBackground()
        // tabBarAppearance.backgroundColor = UIColor.pointBlue
        // // 스크롤 엣지가 닿았을 때 탭바 appearance settings
        // UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        // // 일반 탭바 appearance settings
        // UITabBar.appearance().standardAppearance = tabBarAppearance
        
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        let dashboardVC = DashboardViewController()
        let dashboardNaviVC = UINavigationController(rootViewController: dashboardVC)
        
        self.window = window
        self.window?.rootViewController = dashboardNaviVC
        self.window?.makeKeyAndVisible()
    }
    
    // func makeTabVC() -> UITabBarController {
    //     
    //     let tabVC = UITabBarController()
        // let dashboardVC = DashboardViewController()
        // let dashboardNaviVC = UINavigationController(rootViewController: dashboardVC)
    //     dashboardNaviVC.tabBarItem = makeTabBarItem(item: "house", selected: "house.fill")
    //     
    //     let tripCardVC = TripCardViewController()
    //     let tripCardNaviVC = UINavigationController(rootViewController: tripCardVC)
    //     tripCardNaviVC.tabBarItem = makeTabBarItem(item: "shippingbox", selected: "shippingbox.fill")
    //     
    //     tabVC.setViewControllers([dashboardNaviVC, tripCardNaviVC], animated: false)
    //     
    //     return tabVC
    // }
    
    func makeTabBarItem(item: String, selected: String) -> UITabBarItem {
        
        let configuration = UIImage.SymbolConfiguration(scale: .medium)
        
        let item = UIImage(systemName: item)?.withTintColor(.white, renderingMode: .alwaysOriginal).withConfiguration(configuration)
        let seletedItem = UIImage(systemName: selected)?.withTintColor(.white, renderingMode: .alwaysOriginal).withConfiguration(configuration)
        let tabItem = UITabBarItem(title: nil, image: item, selectedImage: seletedItem)
        
        return tabItem
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

