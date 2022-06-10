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
    
    func fetchMainCities() async throws {
        do {
            let apiRequest = try APIEndPoint.init().test().asUrlRequest()
            let task: Result<CityWeatherDTO,NetworkServiceErrors> = try await networkService.request(request: apiRequest)
            
            switch task {
            case.success(let data) :
                print(data)
            case.failure(let err):
                throw err
            }
            
        } catch {
            throw error
        }
    }
    
}
