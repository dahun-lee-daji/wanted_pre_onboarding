//
//  DefaultWeatherRepository.swift
//  WeatherInfo
//
//  Created by 이다훈 on 2022/06/09.
//

import Foundation

class DefaultWeatherRepository: WeatherRepository {
    private let networkService: NetworkService
    
    init(networkService: NetworkService = DefaultNetworkService.init()) {
        self.networkService = networkService
    }
    
    func fetchCity(code: APIEndPoint.CityCode) async throws -> CityWeatherDTO {
        do {
            let request = try APIEndPoint.init().getEndPoint(city: code).asUrlRequest()
            
            let task: Result<CityWeatherDTO,NetworkServiceErrors> = try await networkService.request(request: request)
            
            switch task {
            case.success(let data) :
                return data
            case.failure(let err):
                throw err
            }
            
        } catch {
            throw error
        }
        
    }
    
    func fetchMainCities() async throws -> [CityWeatherDTO] {
        var cities = [CityWeatherDTO]()
        do {
            let endPoints = APIEndPoint.init().getAllCityEndPoint()
            let apiRequests = try endPoints.map({
                try $0.asUrlRequest()
            })
            
            for request in apiRequests {
                let task: Result<CityWeatherDTO,NetworkServiceErrors> = try await networkService.request(request: request)
                
                switch task {
                case.success(let data) :
                    cities.append(data)
                case.failure(let err):
                    throw err
                }
            }
            
        } catch {
            throw error
        }
        
        return cities
    }
    
}
