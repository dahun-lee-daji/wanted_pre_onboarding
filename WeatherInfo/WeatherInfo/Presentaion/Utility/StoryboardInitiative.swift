//
//  StoryboardInitiative.swift
//  WeatherInfo
//
//  Created by 이다훈 on 2022/06/10.
//

import UIKit

protocol StoryboardInitiative: AnyObject {
    associatedtype T
    static var defaultFileName: String {get}
    static func initiate(_ with: Bundle?) -> T
}

extension StoryboardInitiative where Self: UIViewController {
    static var defaultFileName: String {
        return NSStringFromClass(Self.self).components(separatedBy: ".").last!
    }
    
    static var question: String {
        return NSStringFromClass(Self.self)
    }
    
    static func initiate(_ with: Bundle? = nil) -> Self {
        let fileName = defaultFileName
        let storyBoard = UIStoryboard.init(name: fileName, bundle: with)
        guard let vc = storyBoard.instantiateInitialViewController() as? Self else {
            fatalError("\(Self.self) StoryboardInitiative.create Fail with file name \(fileName)")
        }
        return vc
    }
}
