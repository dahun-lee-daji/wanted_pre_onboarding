//
//  WeatherRepository.swift
//  WeatherInfo
//
//  Created by 이다훈 on 2022/06/09.
//

import Foundation

protocol WeatherRepository {
    func fetchMainCities() async throws -> [CityWeatherDTO]
    func fetchCity(code: APIEndPoint.CityCode) async throws -> CityWeatherDTO
    func fetchCity(code: Int) async throws -> CityWeatherDTO
    func fetchCitySimple(code: APIEndPoint.CityCode) async throws -> SimpleWeatherInfo
}
