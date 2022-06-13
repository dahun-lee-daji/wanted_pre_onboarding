//
//  DetailWeatherViewController.swift
//  WeatherInfo
//
//  Created by 이다훈 on 2022/06/13.
//

import UIKit

class DetailWeatherViewController: UIViewController {
    
    private var viewModel: MainWeatherViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension DetailWeatherViewController: StoryboardInitiative {
    static func create(with: MainWeatherViewModel) -> Self {
        let vc = self.initiate(nil)
        vc.viewModel = with
        return vc
    }
    
}
