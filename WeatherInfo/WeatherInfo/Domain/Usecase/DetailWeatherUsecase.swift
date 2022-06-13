//
//  DetailWeatherUsecase.swift
//  WeatherInfo
//
//  Created by 이다훈 on 2022/06/13.
//

import Foundation

protocol DetailWeatherUsecase {
    func fetchCityInfo(closure: @escaping (CityWeatherDTO) -> Void) throws
}

class DefaultDetailWeatherUsecase: DetailWeatherUsecase {
    
    private let repository: WeatherRepository
    private let targetId: Int
    
    init(weatherRepo: WeatherRepository, id: Int) {
        self.repository = weatherRepo
        self.targetId = id
    }
    
    func fetchCityInfo(closure: @escaping (CityWeatherDTO) -> Void) throws {
        Task {
            do {
                let data = try await repository.fetchCity(code: targetId)
                closure(data)
            } catch {
                throw error
            }
            
        }
        
    }
}
