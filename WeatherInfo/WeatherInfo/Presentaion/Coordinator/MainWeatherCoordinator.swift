//
//  MainWeatherCoordinator.swift
//  WeatherInfo
//
//  Created by 이다훈 on 2022/06/10.
//

import UIKit

protocol MainWeatherCoordinatorDependencies {
    func  makeMainWeatherViewController(actions: MainWeatherViewModelActions) -> MainWeatherViewController
    
}

class MainWeatherCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let dependencies: MainWeatherCoordinatorDependencies
    
    init(navigation: UINavigationController,
         dependencies: MainWeatherCoordinatorDependencies) {
        self.navigationController = navigation
        self.dependencies = dependencies
    }
    
    func start() {
        let vc = dependencies.makeMainWeatherViewController(actions: .init())
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
