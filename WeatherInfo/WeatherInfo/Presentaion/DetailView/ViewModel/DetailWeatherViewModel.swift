//
//  DetailWeatherViewModel.swift
//  WeatherInfo
//
//  Created by 이다훈 on 2022/06/13.
//

import Foundation

protocol DetailWeatherViewModelInput {
    
}

protocol DetailWeatherViewModelOutput {
    
}

protocol DetailWeatherViewModel: DetailWeatherViewModelInput, DetailWeatherViewModelOutput {
    
}

struct DetailWeatherViewModelActions {
    
}

class DefaultDetailWeatherViewModel: DetailWeatherViewModel {
    
    private let useCase: DetailWeatherUsecase
    private let actions: DetailWeatherViewModelActions
    
    
    init(detailWeatherUseCase: DetailWeatherUsecase, actions: DetailWeatherViewModelActions) {
        self.useCase = detailWeatherUseCase
        self.actions = actions
    }
    
}

extension DefaultDetailWeatherViewModel {
    // - MARK: Input
}
