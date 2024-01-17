//
//  ViewController.swift
//  Weather
//
//  Created by spark-03 on 2024/01/11.
//

import UIKit
//import YumemiWeather

class ViewController: UIViewController {
    
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    let yumemitenki = YumemiTenki()
    
    @IBOutlet weak var WeatherImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        yumemitenki.delegate = self
        
        NotificationCenter.default.addObserver(
            self,selector: #selector(road),
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
    }
       
    @objc func road() {
                yumemitenki.setYumemiWeather()
        }
    
    
    @IBAction func WeatherChange(_ sender: Any) {
        yumemitenki.setYumemiWeather()
    }
    
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true,completion: nil)
    }
}


extension ViewController:YumemiDelegate {
    func setWeatherTempMax(max: Int) {
           self.maxTempLabel.text = String(max)
    }

    func setWeatherTempMin(min: Int) {
        self.minTempLabel.text = String(min)
    }
    
    func setErrorMessage(alert: String) {
        let alertController = UIAlertController(title: alert, message: "エラー", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "閉じる", style: .default, handler: nil))
        present(alertController, animated: false, completion: nil)
    }
    
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
