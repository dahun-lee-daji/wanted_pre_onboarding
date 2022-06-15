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
        viewModel.loadData {
            DispatchQueue.main.async {[unowned self] in
                bind()
            }
        }
        
    }
    
    func bind() {
        viewModel.detailData.bind({ [unowned self] data in
            guard let data = data else {
                return
            }
            
            cityNameLabel.text = data.city
            currentTempLabel.text = data.temperature
            feeingTempLabel.text = data.feelingTemperature
            currentHumidityLabel.text = data.currentHumidity
            lowTempLabel.text = data.lowTemperature
            highTempLabel.text = data.highTemperature
            atmPressureLabel.text = data.atmospherePressureLabel
            windSpeedLabel.text = data.windSpeed
            weatherDescLabel.text = data.weatherDescription
        })
        
        viewModel.imageData.bind({ [unowned self] imageData in
            iconImageView.image = UIImage.init(data: imageData)
        })
    }
    
}

extension DetailWeatherViewController: StoryboardInitiative {
    static func create(with: DetailWeatherViewModel) -> Self {
        let vc = self.initiate(nil)
        vc.viewModel = with
        return vc
    }
    
}
