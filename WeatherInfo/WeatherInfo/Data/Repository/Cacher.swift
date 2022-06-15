//
//  Cacher.swift
//  WeatherInfo
//
//  Created by 이다훈 on 2022/06/15.
//

import UIKit

protocol Cacher {
    associatedtype T: AnyObject
    
    
    var container: NSCache<NSString, T> {get}
    
    func setCache(with data: T, id: String)
    func getCache(id: String) -> T?
}

extension Cacher {
    
    func setCache(with data: T, id: String) {
        container.setObject(data, forKey: id as NSString)
    }
    
    func getCache(id: String) -> T? {
        container.object(forKey: id as NSString)
    }
}


class WeatherCacher: Cacher {
    typealias T = CachedCityInfo
    
    static var shared = WeatherCacher()
    
    private init() {
    }
    
    let container = NSCache<NSString, T>()
    
}

class ImageCacher: Cacher {
    typealias T = CachedImage
    
    static var shared = ImageCacher()
    
    private init() {
    }
    
    let container = NSCache<NSString, T>()
    
}

class CachedCityInfo {
    var cached: CityWeatherDTO
    
    init(with data: CityWeatherDTO) {
        cached = data
    }
}

class CachedImage {
    var cached: UIImage
    
    init(with data: Data) {
        cached = UIImage.init(data: data) ?? UIImage()
    }
}
