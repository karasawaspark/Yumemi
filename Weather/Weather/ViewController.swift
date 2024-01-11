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
        switch responseWeatherStr {
        case "sunny" :
            WeatherImageView.image = UIImage(named:responseWeatherStr)?.withRenderingMode(.alwaysTemplate)
            self.WeatherImageView.tintColor = .red
        case "cloudy" :
            WeatherImageView.image = UIImage(named:responseWeatherStr)?.withRenderingMode(.alwaysTemplate)
            self.WeatherImageView.tintColor = .gray
        case "rainy" :
            WeatherImageView.image = UIImage(named:responseWeatherStr)?.withRenderingMode(.alwaysTemplate)
            self.WeatherImageView.tintColor = .blue
        default:
            break
        }
    }
}
            //
            //        func drowImageView () {
            //            WeatherImageView.image = UIImage(named: aaa)
            //        }
            //
            //        func colorImageView () {
            //            WeatherImageView.image = UIImage(named: aaa)?.withRenderingMode(<#T##renderingMode: UIImage.RenderingMode##UIImage.RenderingMode#>)
            
            
 
