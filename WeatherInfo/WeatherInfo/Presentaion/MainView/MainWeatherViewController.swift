//
//  MainWeatherViewController.swift
//  WeatherInfo
//
//  Created by 이다훈 on 2022/06/09.
//

import UIKit

class MainWeatherViewController: UIViewController, StoryboardInitiative {
    
    @IBOutlet weak var weatherCollectionView: UICollectionView!
    
    private var viewModel: MainWeatherViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("helloWorld\(viewModel)")
    }

}

extension MainWeatherViewController {
    static func create(with: MainWeatherViewModel) -> Self {
        let vc = self.initiate(nil)
        vc.viewModel = with
        return vc
    }
    
}

