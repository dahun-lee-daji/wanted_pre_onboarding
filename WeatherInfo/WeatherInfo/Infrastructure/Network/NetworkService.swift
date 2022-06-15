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
    func request<T: Codable>(request: URLRequest) async throws -> Result<T,NetworkServiceErrors>
    func request(request: URLRequest) async throws -> Data
}

class DefaultNetworkService: NetworkService {
    
    let networkRequester: NetworkRequester
    
    init(requester: NetworkRequester = DefaultNetworkRequester.init()) {
        self.networkRequester = requester
    }
    
    func request<T:Codable>(request: URLRequest) async throws -> Result<T, NetworkServiceErrors> {
        
        do {
            let data = try await networkRequester.request(request: request)
            return try decode(data: data)
        } catch {
            throw error
        }
    }
    
    func request(request: URLRequest) async throws -> Data {
        
        do {
            let data = try await networkRequester.request(request: request)
            return data
        } catch {
            throw error
        }
    }
    
    private func decode<T:Codable> (data: Data?) throws -> Result<T,NetworkServiceErrors> {
        guard let data = data else {
            return .failure(.failDecodeNilData)
        }
        
        let decoded = try JSONDecoder().decode(T.self, from: data)
        
        return .success(decoded)
    }
}
