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
        print("hello World")
        let repo = DefaultWeatherRepository.init()
        repo.fetchMainCities()
    }

    func getData()  async  -> Data {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=London,uk&APPID=\(APIKeys.init().info)")!
//    api.openweathermap.org/data/3.0/onecall?lat={lat}&lon={lon}&exclude={part}&appid={API key}
        let data = try! Data(contentsOf: url)
        return data
    }
    
    func decode(data: Data) async  -> String {
        let contents = String(data: data, encoding: .utf8)!
        return contents
    }
    
    func process() async {
       let data =  await  self.getData()
       let contents =  await  self.decode(data: data)
       print(contents)
    }
    

}

