//
//  DetailWeatherViewController.swift
//  WeatherInfo
//
//  Created by 이다훈 on 2022/06/13.
//

import UIKit

class DetailWeatherViewController: UIViewController {
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var feeingTempLabel: UILabel!
    @IBOutlet weak var currentHumidityLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var atmPressureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var weatherDescLabel: UILabel!
    
    private var viewModel: DetailWeatherViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("detailDidLoad")
    }
    
}

extension DetailWeatherViewController: StoryboardInitiative {
    static func create(with: DetailWeatherViewModel) -> Self {
        let vc = self.initiate(nil)
        vc.viewModel = with
        return vc
    }
    
}
