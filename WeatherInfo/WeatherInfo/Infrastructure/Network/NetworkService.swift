//
//  NetworkService.swift
//  WeatherInfo
//
//  Created by 이다훈 on 2022/06/09.
//

import Foundation

enum NetworkServiceErrors: Error {
    case failDecodeNilData
    case invalidData(data: Data)
}

protocol NetworkService {
    func request<T: Codable>(url: URL) async throws -> Result<T,NetworkServiceErrors>
}

class DefaultNetworkService: NetworkService {
    
    let networkRequester: NetworkRequester
    
    init(requester: NetworkRequester = DefaultNetworkRequester.init()) {
        self.networkRequester = requester
    }
    
    func request<T:Codable>(url: URL) async throws -> Result<T, NetworkServiceErrors> {
        let data = try await networkRequester.request(url: url)
        
        return decode(data: data)
    }
    
    private func decode<T:Codable> (data: Data?) -> Result<T,NetworkServiceErrors> {
        guard let data = data else {
            return .failure(.failDecodeNilData)
        }
        
        let decoder = try? JSONDecoder().decode(T.self, from: data)
        guard let decoded = decoder else {
            return .failure(.invalidData(data: data))
        }
        return .success(decoded)
    }
}
