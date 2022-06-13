//
//  MainWeatherUsecase.swift
//  WeatherInfo
//
//  Created by 이다훈 on 2022/06/10.
//

import Foundation

protocol MainWeatherUsecase {
    func fetchMainCities(closure: @escaping ([CityWeatherDTO]) -> Void) throws
}

class DefaultMainWeatherUsecase: MainWeatherUsecase {
    
    private let repository: WeatherRepository
    
    init(weatherRepo: WeatherRepository) {
        self.repository = weatherRepo
    }
    
    func fetchMainCities(closure: @escaping ([CityWeatherDTO]) -> Void) throws {
        Task {
            do {
                let data = try await repository.fetchMainCities()
                closure(data)
            } catch {
                throw error
            }
            
        }
        
    }
    
}
