//
//  MainWeatherUsecase.swift
//  WeatherInfo
//
//  Created by 이다훈 on 2022/06/10.
//

import Foundation

protocol MainWeatherUsecase {
    func test(closure: @escaping (CityWeatherDTO) -> Void ) throws
    func test2(closure: @escaping ([CityWeatherDTO]) -> Void) throws
}

class DefaultMainWeatherUsecase: MainWeatherUsecase {
    
    private let repository: WeatherRepository
    
    init(weatherRepo: WeatherRepository) {
        self.repository = weatherRepo
    }
    
    func test(closure: @escaping (CityWeatherDTO) -> Void ) throws {
        Task {
            do {
                for code in APIEndPoint.CityCode.allCases {
                    let data = try await repository.fetchCity(code: code)
                    closure(data)
                }
                
            } catch {
                throw error
            }
            
        }
    }
    
    func test2(closure: @escaping ([CityWeatherDTO]) -> Void) throws {
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
