//
//  MainWeatherUsecase.swift
//  WeatherInfo
//
//  Created by 이다훈 on 2022/06/10.
//

import Foundation

protocol MainWeatherUsecase {
    func fetchMainCities(closure: @escaping ([CityWeatherDTO]) -> Void) throws
    func fetchImage(id: String, closure: @escaping (Data) -> Void) throws
}

class DefaultMainWeatherUsecase: MainWeatherUsecase {
    
    private let weatherRepository: WeatherRepository
    private let imageRepository: ImageRepository
    
    init(weatherRepository: WeatherRepository,
         imageRepository: ImageRepository) {
        self.weatherRepository = weatherRepository
        self.imageRepository = imageRepository
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
    
    func fetchMainCities(closure: @escaping ([CityWeatherDTO]) -> Void) throws {
        Task {
            do {
                let data = try await weatherRepository.fetchMainCities()
                closure(data)
            } catch {
                throw error
            }
            
        }
        
    }
    
}
