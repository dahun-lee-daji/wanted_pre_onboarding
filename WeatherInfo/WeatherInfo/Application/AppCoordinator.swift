//
//  AppCoordinator.swift
//  WeatherInfo
//
//  Created by 이다훈 on 2022/06/10.
//

import UIKit

class AppCoordinator {
    
    private let navigationController: UINavigationController
    private let appDIContainer: AppDiContainer
    
    init(navigation: UINavigationController, container: AppDiContainer) {
        self.navigationController = navigation
        self.appDIContainer = container
    }
    
    func start() {
        let sceneDiContainer = appDIContainer.makeSceneDIContainer()
        let coordinator = sceneDiContainer.makeMainWeatherCoordinator(navigationController: navigationController)
        coordinator.start()
    }
}
