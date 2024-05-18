//
//  SceneDelegate.swift
//  WhatsNew
//
//  Created by Afonso Lucas on 14/05/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var router: RouterProtocol?
    
    private let apiKey = "0492ec875ce848ba83d18e14941bf98e"

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()
        let viewModelProvider = ViewModelProvider(newsApiKey: apiKey)
        
        self.router = AppRouter(navigationController: navigationController,
                                viewModelProvder: viewModelProvider)
        self.router?.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}

