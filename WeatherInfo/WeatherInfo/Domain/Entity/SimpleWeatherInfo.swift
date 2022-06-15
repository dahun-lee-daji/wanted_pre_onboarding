//
//  SimpleWeatherInfo.swift
//  WeatherInfo
//
//  Created by 이다훈 on 2022/06/10.
//

import Foundation

struct SimpleWeatherInfo: Hashable {
    
    let icon: String
    let city: String
    let humidity: Int
    let temperature: Float
    let id: Int
    
    init(icon: String, city: String, humidity: Int, temp: Float, id: Int) {
        self.icon = icon
        self.city = city
        self.humidity = humidity
        self.temperature = temp
        self.id = id
    }
    
    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(icon)
        hasher.combine(city)
        hasher.combine(humidity)
        hasher.combine(temperature)
        hasher.combine(id)
    }
    
    static func == (lhs: SimpleWeatherInfo, rhs: SimpleWeatherInfo) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
}
