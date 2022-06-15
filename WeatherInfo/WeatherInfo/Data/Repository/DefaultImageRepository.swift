//
//  DefaultImageRepository.swift
//  WeatherInfo
//
//  Created by 이다훈 on 2022/06/15.
//

import Foundation

class DefaultImageRepository: ImageRepository {
    
    private let networkService: NetworkService
    private let imageCacher: ImageCacher
    
    init(networkService: NetworkService = DefaultNetworkService.init(),
         imageCacher: ImageCacher) {
        self.networkService = networkService
        self.imageCacher = imageCacher
    }
    
    func fetchImage(id: String) async throws -> Data {
        do {
            
            if let cached = getCache(id: id) {
                return cached
            }
            
            let request = try APIEndPoint.init().getImageEndPoint(id: id).asUrlRequest()

            let data: Data = try await networkService.request(request: request)
            
            setCache(data: data, id: id)
            return data
        } catch {
            throw error
        }
    }
    
    private func setCache(data: Data, id: String) {
        let imageToCache = CachedImage.init(with: data)
        imageCacher.setCache(with: imageToCache, id: id)
    }
    
    private func getCache(id: String) -> Data? {
        imageCacher.getCache(id: id)?.cached.pngData()
    }
    
}

