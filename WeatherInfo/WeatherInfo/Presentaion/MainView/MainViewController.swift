//
//  ViewController.swift
//  WeatherInfo
//
//  Created by 이다훈 on 2022/06/09.
//

import UIKit

class MainViewController: UIViewController, StoryboardInitiative {
    
    private var viewModel: MainWeatherViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("helloWorld\(viewModel)")
    }

}

extension MainViewController {
    static func create(with: MainWeatherViewModel) -> Self {
        let vc = self.initiate(nil)
        vc.viewModel = with
        return vc
    }
    
}

