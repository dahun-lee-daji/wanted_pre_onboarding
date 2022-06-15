//
//  MainWeatherCoordinator.swift
//  WeatherInfo
//
//  Created by 이다훈 on 2022/06/10.
//

import UIKit

protocol MainWeatherCoordinatorDependencies {
    func makeMainWeatherViewController(actions: MainWeatherViewModelActions) -> MainWeatherViewController
    func makeDetailWeatherViewController(actions: DetailWeatherViewModelActions, id: Int) -> DetailWeatherViewController
    
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
        let vc = dependencies
            .makeMainWeatherViewController(actions:
                    .init(pushDetailView: pushDetail)
            )
        
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    private func pushDetail(id: Int) {
        let detailVC = dependencies
            .makeDetailWeatherViewController(actions: .init(popWithError: popTopView),
                                             id: id)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    private func popTopView(error: Error) {
        self.navigationController?.popViewController(animated: true)
        //present error popup
    }
}
