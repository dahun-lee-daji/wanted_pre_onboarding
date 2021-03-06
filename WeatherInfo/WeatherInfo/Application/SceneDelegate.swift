//
//  SceneDelegate.swift
//  WeatherInfo
//
//  Created by 이다훈 on 2022/06/09.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let appDiContainer = AppDiContainer()
    var appCoordinator: AppCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow.init(windowScene: windowScene)
        
        let navigationController: UINavigationController = .init()
        window?.rootViewController = navigationController
        
        appCoordinator = AppCoordinator.init(navigation: navigationController, container: appDiContainer)
        appCoordinator?.start()
        
        window?.makeKeyAndVisible()
        
    }


}

