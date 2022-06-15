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
    var detailData: Observable<DetailWeatherInfo?> {get}
    var imageData: Observable<Data> {get}
    func loadData(closure: @escaping () -> Void)
}

protocol DetailWeatherViewModel: DetailWeatherViewModelInput, DetailWeatherViewModelOutput {
    
}

struct DetailWeatherViewModelActions {
    let popWithError: (Error) -> Void
}

class DefaultDetailWeatherViewModel: DetailWeatherViewModel {
    
    private let useCase: DetailWeatherUsecase
    private let actions: DetailWeatherViewModelActions
    
    // - MARK: LifeCycle
    
    init(detailWeatherUseCase: DetailWeatherUsecase, actions: DetailWeatherViewModelActions) {
        self.useCase = detailWeatherUseCase
        self.actions = actions
    }
    
    func loadData(closure: @escaping () -> Void) {
        do {
            try useCase.fetchCityInfo(closure: { [unowned self] loaded in
                guard let detail = loaded.toDetailInfo() else {
                    return
                }
                loadImage(id: detail.icon)
                detailData = Observable(detail)
                closure()
            })
        } catch {
            actions.popWithError(error)
        }
    }
    
    private func loadImage(id: String) {
        do {
            try useCase.fetchImage(id: id, closure: { [unowned self] loaded in
                imageData = Observable(loaded)
            })
        } catch {
            actions.popWithError(error)
        }
    }
    
    // - MARK: Input
    
    var detailData = Observable<DetailWeatherInfo?>.init(nil)
    var imageData = Observable<Data>(Data.init())
    
}

extension DefaultDetailWeatherViewModel {
    // - MARK: Input
}
