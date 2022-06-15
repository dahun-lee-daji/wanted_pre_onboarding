//
//  CityWeatherDTO.swift
//  WeatherInfo
//
//  Created by 이다훈 on 2022/06/10.
//

import Foundation

struct WeatherCodes: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

struct MainWeatherInfo: Codable {
    var temperature: Float
    var makeFeel: Float
    var minTemp: Float
    var maxTemp: Float
    var pressure: Int
    var humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case makeFeel = "feels_like"
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
        case pressure, humidity
    }
}

/// direction: Wind direction, degrees (meteorological)
struct Wind: Codable {
    var speed: Float
    var direction: Int
    
    enum CodingKeys: String, CodingKey {
        case speed
        case direction = "deg"
    }
}
// all is percent of clouds
struct Clouds: Codable {
    var all: Int
}

struct CityWeatherDTO: Codable {
    var weatherCodes: [WeatherCodes]
    var base: String //internal param
    var mainInfo: MainWeatherInfo
    var visibility: Int //The maximum value of the visibility is 10km = 10000
    var wind: Wind
    var clouds: Clouds
    var dt: Int //Time of data calculation, unix, UTC
    var timezone: Int
    var id: Int
    var name: String
    var cod: Int
    
    enum CodingKeys: String, CodingKey {
        case weatherCodes = "weather"
        case mainInfo = "main"
        case base, visibility, wind, clouds, dt, timezone, id, name, cod
    }
    
    func toSimple() -> SimpleWeatherInfo? {
        guard let icon = weatherCodes.first?.icon else {
            return nil
        }
        return SimpleWeatherInfo.init(icon: icon,
                                      city: name,
                                      humidity: mainInfo.humidity,
                                      temp: mainInfo.temperature,
                                      id: id)
    }
    
    func toDetailInfo() -> DetailWeatherInfo? {
        guard let firstCode = weatherCodes.first else {
            return nil
        }
        
        return DetailWeatherInfo
            .init(icon: firstCode.icon,
                  city: name,
                  temperature: mainInfo.temperature.formatted(),
                  feelingTemperature: mainInfo.makeFeel.formatted(),
                  currentHumidity: mainInfo.humidity.formatted(),
                  lowTemperature: mainInfo.minTemp.formatted(),
                  highTemperature: mainInfo.maxTemp.formatted(),
                  atmospherePressureLabel: mainInfo.pressure.formatted(),
                  windSpeed: wind.speed.formatted(),
                  weatherDescription: firstCode.description)
    }
}

extension CityWeatherDTO: Equatable {
    static func == (lhs: CityWeatherDTO, rhs: CityWeatherDTO) -> Bool {
        lhs.id == rhs.id
    }
    
}
