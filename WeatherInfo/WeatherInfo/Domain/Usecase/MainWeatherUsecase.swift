//
//  MainWeatherUsecase.swift
//  WeatherInfo
//
//  Created by 이다훈 on 2022/06/10.
//

import Foundation

protocol MainWeatherUsecase {
    
}

class DefaultMainWeatherUsecase: MainWeatherUsecase {
    
    private let repository: WeatherRepository
    
    init(weatherRepo: WeatherRepository) {
        self.repository = weatherRepo
    }
}
