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
    var data: Observable<[CityWeatherDTO]> {get}
    func loadData( closure: @escaping () -> Void)
    func getImageData(id: String, closure: @escaping (Data) -> Void)
}

protocol MainWeatherViewModel: MainWeatherViewModelInput, MainWeatherViewModelOutput {
    
}

struct MainWeatherViewModelActions {
    let pushDetailView: (Int) -> Void
}

class DefaultMainWeatherViewModel: MainWeatherViewModel {
    
    private let useCase: MainWeatherUsecase
    private let actions: MainWeatherViewModelActions
    
    // - MARK: LifeCycle
    
    init(mainWeatherUseCase: MainWeatherUsecase, actions: MainWeatherViewModelActions) {
        self.useCase = mainWeatherUseCase
        self.actions = actions
    }
    
    
    // - MARK: Output
    
    var data: Observable<[CityWeatherDTO]> = .init([])
    
    func getImageData(id: String, closure: @escaping (Data) -> Void) {
        do {
            try useCase.fetchImage(id: id, closure: closure)
        } catch {
            print(error)
        }
    }
    
    func loadData( closure: @escaping () -> Void) {
        do {
            try useCase.fetchMainCities(closure: {
                self.data = Observable($0)
                closure()
            })
            
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
