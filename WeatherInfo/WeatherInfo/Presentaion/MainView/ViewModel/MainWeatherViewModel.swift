//
//  MainWeatherViewModel.swift
//  WeatherInfo
//
//  Created by 이다훈 on 2022/06/10.
//

import Foundation

protocol MainWeatherViewModelInput {
    func isEqualIfNotReload(with: [CityWeatherDTO])
}

protocol MainWeatherViewModelOutput {
    var data: [CityWeatherDTO] {get}
}

protocol MainWeatherViewModel: MainWeatherViewModelInput, MainWeatherViewModelOutput {
    
}

struct MainWeatherViewModelActions {
    let reload : () -> Void
}

class DefaultMainWeatherViewModel: MainWeatherViewModel {
    
    private let useCase: MainWeatherUsecase
    private let actions: MainWeatherViewModelActions
    var data = [CityWeatherDTO]() {
        didSet {
            actions.reload()
        }
    }
    
    init(mainWeatherUseCase: MainWeatherUsecase, actions: MainWeatherViewModelActions) {
        self.useCase = mainWeatherUseCase
        self.actions = actions
        loadData()
    }
    
    private func loadData() {
        do {
            try useCase.test2(closure: {
                self.data = $0
            })
            
        } catch {
            print(error)
        }
        
    }
    
}

extension DefaultMainWeatherViewModel {
    // - MARK: Input
    
    func isEqualIfNotReload(with: [CityWeatherDTO]) {
        if with != self.data {
            actions.reload()
        }
    }
}
