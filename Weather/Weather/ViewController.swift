//
//  ViewController.swift
//  Weather
//
//  Created by spark-03 on 2024/01/11.
//

import UIKit
//import YumemiWeather

class ViewController: UIViewController {
    
    let yumemitenki = YumemiTenki()
    
    @IBOutlet weak var WeatherImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        yumemitenki.delegate = self
    }
    
    @IBAction func WeatherChange(_ sender: Any) {
        yumemitenki.setYumemiWeather()
    }
    
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true,completion: nil)
    }
}

extension ViewController:YumemiDelegate {
       
        func setWeatherImage(type: String) {
            var imageName = "sunny"
            var tintColor = UIColor.red
            
            switch type {
            case "sunny":
                imageName = "sunny"
                tintColor = UIColor.red
            case "cloudy":
                imageName = "cloudy"
                tintColor = UIColor.gray
            case "rainy":
                imageName = "rainy"
                tintColor = UIColor.blue
            default:
                break
            }
            
            WeatherImageView.image = UIImage(named: imageName)
            WeatherImageView.tintColor = tintColor
        }
    }

/* func setWeatherError(alertMessage: String) {
//アラートのタイトルは「確認」などにしてmessageに内容を入れるのが一般的

let alert = UIAlertController(title: "確認", message: alertMessage, preferredStyle: alert)
/*
