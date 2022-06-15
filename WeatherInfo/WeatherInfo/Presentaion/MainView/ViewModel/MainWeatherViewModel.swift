//
//  MainWeatherViewModel.swift
//  WeatherInfo
//
//  Created by 이다훈 on 2022/06/10.
//

import Foundation

protocol MainWeatherViewModelInput {
    func selectedItem(id: Int)
}

protocol MainWeatherViewModelOutput {
    var data: [CityWeatherDTO] {get}
    func getImageData(id: String, closure: @escaping (Data) -> Void)
}

protocol MainWeatherViewModel: MainWeatherViewModelInput, MainWeatherViewModelOutput {
    
}

struct MainWeatherViewModelActions {
    let reload: () -> Void
    let pushDetailView: (Int) -> Void
}

class DefaultMainWeatherViewModel: MainWeatherViewModel {
    
    private let useCase: MainWeatherUsecase
    private let actions: MainWeatherViewModelActions
    
    // - MARK: LifeCycle
    
    init(mainWeatherUseCase: MainWeatherUsecase, actions: MainWeatherViewModelActions) {
        self.useCase = mainWeatherUseCase
        self.actions = actions
        loadData()
    }
    
    private func loadData() {
        do {
            try useCase.fetchMainCities(closure: {
                self.data = $0
            })
            
        } catch {
            print(error)
        }
    }
    
    // - MARK: Output
    
    var data = [CityWeatherDTO]() {
        didSet {
            actions.reload()
        }
    }
    
    func getImageData(id: String, closure: @escaping (Data) -> Void) {
        do {
            try useCase.fetchImage(id: id, closure: closure)
        } catch {
            print(error)
        }
        
    }
    
}

extension DefaultMainWeatherViewModel {
    // - MARK: Input
    func selectedItem(id: Int) {
        actions.pushDetailView(id)
    }
}
