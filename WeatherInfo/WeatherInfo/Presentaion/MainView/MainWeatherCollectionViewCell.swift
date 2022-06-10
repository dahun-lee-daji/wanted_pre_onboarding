//
//  MainWeatherCollectionViewCell.swift
//  WeatherInfo
//
//  Created by 이다훈 on 2022/06/10.
//

import UIKit

class MainWeatherCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    var id : Int!
    
    func configure(with item: SimpleWeatherInfo) {
        self.cityNameLabel.text = item.city
        self.humidityLabel.text = item.humidity
        self.temperatureLabel.text = "\(item.temperature)"
        self.id = item.id
    }
}

