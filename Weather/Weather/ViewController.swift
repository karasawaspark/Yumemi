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
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    let yumemitenki = YumemiTenki()
    
    @IBOutlet weak var WeatherImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicator.hidesWhenStopped = true
        
        yumemitenki.delegate = self
        
        NotificationCenter.default.addObserver(
            self,selector: #selector(road),
            name: UIApplication.willEnterForegroundNotification,object: nil)
    }
    
    @objc func road() {
        yumemitenki.setYumemiWeather()
    }
    
    @IBAction func WeatherReloadButton(_ sender: Any) {
        self.indicator.startAnimating()
        yumemitenki.setYumemiWeather()
    }
    
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true,completion: nil)
    }
}

extension ViewController:YumemiDelegate {
    
    func setWeatherTempMax(max: Int) {
        DispatchQueue.main.async {
            self.maxTempLabel.text = String(max)
        }
    }
    
    func setWeatherTempMin(min: Int) {
        DispatchQueue.main.async {
            self.minTempLabel.text = String(min)
        }
    }
    
    func setErrorMessage(alert: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: alert, message: "エラー", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "閉じる", style: .default, handler: nil))
            self.present(alertController, animated: false, completion: nil)
        }
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
        
        DispatchQueue.main.async {
            self.WeatherImageView.image = UIImage(named: imageName)
            self.WeatherImageView.tintColor = tintColor
            self.indicator.stopAnimating()
        }
    }
}
