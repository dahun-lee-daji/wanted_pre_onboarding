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
        case image = "/img/wn/"
    }
    
    enum HostType: String {
        case api = "api.openweathermap.org"
        case image = "openweathermap.org"
    }
    
    init() {
    }
    
    private let unitQueryItem: URLQueryItem = .init(name: "units", value: "metric")
    private let languageQueryItem: URLQueryItem = .init(name: "lang", value: "KR")
    private let apiKeyQueryItem: URLQueryItem = .init(name: "APPID", value: APIKeys.init().info)
    
    func getEndPoint(city: CityCode) -> EndPoint {
        let cityId = URLQueryItem.init(name: "id", value: "\(city.rawValue)")
        
        return EndPoint.init(scheme: SchemeType.https.rawValue,
                             host: HostType.api.rawValue,
                             apiPath: ApiPath.weather2half.rawValue,
                             httpMethod: .get,
                             items: [cityId,
                                     unitQueryItem,
                                     languageQueryItem,
                                     apiKeyQueryItem]
        )
    }
    
    func getEndPoint(cityCode: Int) -> EndPoint {
        
        let cityId = URLQueryItem.init(name: "id", value: "\(cityCode)")
        
        return EndPoint.init(scheme: SchemeType.https.rawValue,
                             host: HostType.api.rawValue,
                             apiPath: ApiPath.weather2half.rawValue,
                             httpMethod: .get,
                             items: [cityId,
                                     unitQueryItem,
                                     languageQueryItem,
                                     apiKeyQueryItem]
        )
    }
    
    func getAllCityEndPoint() -> [EndPoint] {
        return CityCode.allCases.map({
            getEndPoint(city: $0)
        })
    }
    
    func getImageEndPoint(id: String) -> EndPoint {
        return EndPoint.init(scheme: SchemeType.https.rawValue,
                             host: HostType.image.rawValue,
                             apiPath: ApiPath.image.rawValue + id + ".png",
                             httpMethod: .get
        )
    }
}

extension APIEndPoint {
    enum CityCode: Int, CaseIterable {
        case gongju = 1842616//공주
        case gwangju = 1841811 // 광주 광역시
        case gumi = 1842225
        case gunsan = 1842025
        case daegu = 1835327
        case daejeon = 1835235
        case mokpo = 1841066
        case busan = 1838519
        case seosan = 1835895
        case seoul = 1835848
        case sokcho = 1836553
        case suwon = 1835553
        case suncheon = 1835648
        case ulsan = 1833742
        case iksan = 1843491
        case jeonju = 1845457
        case jeju = 1846266 // 제주도x 제주시o
        case cheonan = 1845759
        case cheongju = 1845604
        case chuncheon = 1845136
    }
}

