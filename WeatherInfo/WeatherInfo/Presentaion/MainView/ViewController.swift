//
//  ViewController.swift
//  WeatherInfo
//
//  Created by 이다훈 on 2022/06/09.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let repo = DefaultWeatherRepository.init()
        
        Task{
            do {
                let result = try await repo.fetchMainCities()
                print("viewcon \(result)")
            } catch {
                print(error)
            }
        }
        
    }

}

