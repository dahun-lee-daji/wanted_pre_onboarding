//
//  DetailWeatherUsecase.swift
//  WeatherInfo
//
//  Created by 이다훈 on 2022/06/13.
//

import Foundation

protocol DetailWeatherUsecase {
    func fetchCityInfo(closure: @escaping (CityWeatherDTO) -> Void) throws
    func fetchImage(id: String, closure: @escaping (Data) -> Void) throws
}

class DefaultDetailWeatherUsecase: DetailWeatherUsecase {
    
    private let weatherRepository: WeatherRepository
    private let imageRepository: ImageRepository
    private let targetId: Int
    
    init(weatherRepository: WeatherRepository, imageRepository: ImageRepository, id: Int) {
        self.weatherRepository = weatherRepository
        self.imageRepository = imageRepository
        self.targetId = id
    }
    
    func fetchCityInfo(closure: @escaping (CityWeatherDTO) -> Void) throws {
        Task {
            do {
                let data = try await weatherRepository.fetchCity(code: targetId)
                closure(data)
            } catch {
                throw error
            }
            
        }
        
    }
    
    func fetchImage(id: String, closure: @escaping (Data) -> Void) throws {
        Task {
            do {
                let data = try await imageRepository.fetchImage(id: id)
                closure(data)
            } catch {
                throw error
            }
           
        }
    }
}
