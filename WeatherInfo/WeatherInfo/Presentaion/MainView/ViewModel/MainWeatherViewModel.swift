//
//  MainWeatherViewModel.swift
//  WeatherInfo
//
//  Created by 이다훈 on 2022/06/10.
//

import Foundation

protocol MainWeatherViewModelInput {
    
}

protocol MainWeatherViewModelOutput {
    
}

protocol MainWeatherViewModel: MainWeatherViewModelInput, MainWeatherViewModelOutput {
    
}

struct MainWeatherViewModelActions {
    
}

class DefaultMainWeatherViewModel: MainWeatherViewModel {
    
    private let useCase: MainWeatherUsecase
    private let actions: MainWeatherViewModelActions
    
    init(mainWeatherUseCase: MainWeatherUsecase, actions: MainWeatherViewModelActions) {
        self.useCase = mainWeatherUseCase
        self.actions = actions
    }
    
    
}
