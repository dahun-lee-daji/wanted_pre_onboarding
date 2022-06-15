//
//  DefaultWeatherRepository.swift
//  WeatherInfo
//
//  Created by 이다훈 on 2022/06/09.
//

import Foundation
import UIKit

class DefaultWeatherRepository: WeatherRepository {
    
    private let networkService: NetworkService
    private let weatherCacher: WeatherCacher
    
    init(networkService: NetworkService = DefaultNetworkService.init(),
         weatherCacher: WeatherCacher) {
        self.networkService = networkService
        self.weatherCacher = weatherCacher
    }
    
    func fetchCity(code: APIEndPoint.CityCode) async throws -> CityWeatherDTO {
        do {
            if let cached = weatherCacher.getCache(id: "\(code)") {
                return cached.cached
            }
                
            let request = try APIEndPoint.init().getEndPoint(city: code).asUrlRequest()

            let task: Result<CityWeatherDTO,NetworkServiceErrors> = try await networkService.request(request: request)

            switch task {
            case.success(let data) :
                getCache(data: data)
                return data
            case.failure(let err):
                throw err
            }

        } catch {
            throw error
        }
    }
    
    func fetchCity(code: Int) async throws -> CityWeatherDTO {
        do {
            
            if let cached = weatherCacher.getCache(id: "\(code)") {
                return cached.cached
            }
            
            let request = try APIEndPoint.init().getEndPoint(cityCode: code).asUrlRequest()

            let task: Result<CityWeatherDTO,NetworkServiceErrors> = try await networkService.request(request: request)

            switch task {
            case.success(let data) :
                getCache(data: data)
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
            
            for (request,id) in zip(apiRequests, APIEndPoint.CityCode.allCases) {
                
                if let cached = weatherCacher.getCache(id: "\(id.rawValue)") {
                    cities.append(cached.cached)
                }
                
                let task: Result<CityWeatherDTO,NetworkServiceErrors> = try await networkService.request(request: request)
                
                switch task {
                case.success(let data) :
                    getCache(data: data)
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

    
    private func getCache(data: CityWeatherDTO) {
        let dataToCache = CachedCityInfo.init(with: data)
        weatherCacher.setCache(with: dataToCache, id: "\(data.id)")
    }
}
