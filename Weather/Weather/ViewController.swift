//
//  ViewController.swift
//  Weather
//
//  Created by spark-03 on 2024/01/11.
//

import UIKit
import YumemiWeather

class ViewController: UIViewController {
    
    @IBOutlet weak var WeatherImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func WeatherChange(_ sender: Any) {
        getWeatherImage()
    }
    
    func getWeatherImage() {
        
        let responseWeatherStr = YumemiWeather.fetchWeatherCondition()
        
        var imageName = "sunny"
        var tintColor = UIColor.red
        
        switch responseWeatherStr {
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
//git練習
