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
    
    func fetchMainCities() {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=London,uk&APPID=\(APIKeys.init().info)")!
        
        Task {
            let task: Result<Data,NetworkServiceErrors> = try await networkService.request(url: url)
            switch task {
            case.success(let data) :
                print(data)
            case.failure(let err):
                print(err)
            }
        }
    }
    
}
