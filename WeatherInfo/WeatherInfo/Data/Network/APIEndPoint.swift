//
//  APIEndPoint.swift
//  WeatherInfo
//
//  Created by 이다훈 on 2022/06/09.
//

import Foundation

struct APIEndPoint {
    enum SchemeType: String {
        case http = "http"
        case https = "https"
    }
    
    enum ApiPath: String {
        case weather2half = "/data/2.5/weather"
    }
    
    private let scheme: SchemeType
    private let host = "api.openweathermap.org"
    private let apiPath: ApiPath
    
    init(scheme: SchemeType = .https,
         apiPath: ApiPath = .weather2half) {
        self.scheme = scheme
        self.apiPath = apiPath
    }
    
    private let unitQueryItem: URLQueryItem = .init(name: "units", value: "metric")
    private let languageQueryItem: URLQueryItem = .init(name: "lang", value: "KR")
    private let apiKeyQueryItem: URLQueryItem = .init(name: "APPID", value: APIKeys.init().info)
    
    func getEndPoint(city: CityCode) -> EndPoint {
        let cityId = URLQueryItem.init(name: "id", value: "\(city.rawValue)")
        
        return EndPoint.init(scheme: scheme.rawValue,
                             host: host,
                             apiPath: apiPath.rawValue,
                             httpMethod: .get,
                             items: [cityId,
                                     unitQueryItem,
                                     languageQueryItem,
                                     apiKeyQueryItem]
        )
    }
    
}

extension APIEndPoint {
    enum CityCode: Int {
        case seoul = 1835848
    }
}

