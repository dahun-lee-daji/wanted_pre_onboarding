//
//  AppDiContainer.swift
//  WeatherInfo
//
//  Created by 이다훈 on 2022/06/10.
//

import Foundation

class AppDiContainer {
    
    lazy var apiNetworkService: NetworkService = DefaultNetworkService()
    
    func makeSceneDIContainer() -> SceneDIContainer {
        let dependencies = SceneDIContainer
            .Dependencies(apiNetworkService: apiNetworkService)
        return SceneDIContainer(dependencies: dependencies)
    }
}
