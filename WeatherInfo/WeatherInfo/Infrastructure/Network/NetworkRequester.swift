//
//  NetworkRequester.swift
//  WeatherInfo
//
//  Created by 이다훈 on 2022/06/09.
//

import Foundation

protocol NetworkRequester {
    func request(request: URLRequest) async throws -> Data 
}

enum NetworkRequestErrors: Error {
    case invalidResponseWith(url: URL?)
    case invalidStatusCode(statusCode: Int, data: Data?)
    
}

class DefaultNetworkRequester : NetworkRequester {
    
    func request(request: URLRequest) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse else {
            throw NetworkRequestErrors.invalidResponseWith(url: response.url)
        }
        
        if response.statusCode != 200 {
            throw NetworkRequestErrors.invalidStatusCode(statusCode: response.statusCode, data: data)
        }
        
        return data
    }
    
}
