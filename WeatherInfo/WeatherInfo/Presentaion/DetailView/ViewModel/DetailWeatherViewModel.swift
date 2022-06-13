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
    let popWithError: (Error) -> Void
}

class DefaultDetailWeatherViewModel: DetailWeatherViewModel {
    
    private let useCase: DetailWeatherUsecase
    private let actions: DetailWeatherViewModelActions
    
    private var data: CityWeatherDTO! {
        didSet {
            print(data)
        }
    }
    
    init(detailWeatherUseCase: DetailWeatherUsecase, actions: DetailWeatherViewModelActions) {
        self.useCase = detailWeatherUseCase
        self.actions = actions
        loadData()
    }
    
    func loadData() {
        do {
            try useCase.fetchCityInfo(closure: { [unowned self] loaded in
                data = loaded
            })
        } catch {
            actions.popWithError(error)
        }
    }
    
}

extension DefaultDetailWeatherViewModel {
    // - MARK: Input
}
