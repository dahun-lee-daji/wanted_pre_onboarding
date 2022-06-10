//
//  SceneDiContainer.swift
//  WeatherInfo
//
//  Created by 이다훈 on 2022/06/10.
//

import UIKit

class SceneDIContainer {
    
    struct Dependencies {
        let apiNetworkService: NetworkService
    }
    
    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Repositories
    func makeWeatherRepository() -> WeatherRepository {
        return DefaultWeatherRepository(networkService: dependencies.apiNetworkService)
    }
    
    // MARK: - Coordinator
    
    func makeMainWeatherCoordinator(navigationController: UINavigationController) -> MainWeatherCoordinator {
        return MainWeatherCoordinator.init(navigation: navigationController, dependencies: self)
    }
    
    // MARK: - MainWeatherView
    
    func makeMainWeatherUseCase() -> MainWeatherUsecase {
        return DefaultMainWeatherUsecase.init(weatherRepo: makeWeatherRepository())
        }
    
    func makeMainWeatherViewModel(action: MainWeatherViewModelActions) -> MainWeatherViewModel {
        return DefaultMainWeatherViewModel.init(mainWeatherUseCase: makeMainWeatherUseCase(), actions: action)
    }
    
    func makeMainWeatherViewController(actions: MainWeatherViewModelActions) -> MainWeatherViewController {
        return  MainWeatherViewController
            .create(with: makeMainWeatherViewModel(action: actions))
    }
    
}

extension SceneDIContainer: MainWeatherCoordinatorDependencies {
}
