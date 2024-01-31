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
    
    let weatherDatail = WeatherDetail()
    var detailAreas:WeatherResponseList?   //セグエの受け皿（100%変換できるかわからないのでハテナを入れている）
    
    @IBOutlet weak var WeatherImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicator.hidesWhenStopped = true
    
        NotificationCenter.default.addObserver(
            self,selector: #selector(road),
            name: UIApplication.willEnterForegroundNotification,object: nil)
        
        showInfo()
        
        if let areaName = detailAreas?.area {
            self.title = "\(areaName)"
        }else{
            print("error")
        }
        
        /*navigationItem.title = area?.area.rawValue
        or
         if let areaName = area?.area {
         navigationItem.title = areaName.rawValue  rawValueはエリアの中の全てのこと
         }
        */
        
    }
    
    func showInfo() {
        guard let area = self.detailAreas else {return}
        
        var imageName = "sunny"
        var tintColor = UIColor.red
        
        switch area.info.weather_condition {
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
        
        self.WeatherImageView.image = UIImage(named: imageName)
        self.WeatherImageView.tintColor = tintColor
        self.maxTempLabel.text = String(area.info.max_temperature)//最初の画面から情報を入手
        self.minTempLabel.text = String(area.info.min_temperature)//最初の画面から情報を入手
        self.indicator.stopAnimating()
    }
    
    
    func reloadWeather() {
        self.indicator.startAnimating()
        
        Task {
            let result = await weatherDatail.yumemiWeather()
            self.indicator.stopAnimating()
            
            switch result {
            case .success(let (max,min,weather)):
                self.setWeatherInfo(max: max, min: min, weather: weather)
            case .failure(let error):
                self.setErrorMessage(alert:"Error\(error.localizedDescription)")
            }
        }
    }
    
    @objc func road() {
        // weatherDatail.setYumemiWeather()
    }
    
    @IBAction func WeatherReloadButton(_ sender: Any) {
        reloadWeather()
    }
    
    
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true,completion: nil)
    }
    
    func setErrorMessage(alert: String) {
        Task{
            let alertController = UIAlertController(title: alert, message: "エラー", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "閉じる", style: .default, handler: nil))
            self.present(alertController, animated: false, completion: nil)
        }
    }
    
    
    func setWeatherInfo(max:Int,min:Int,weather:String) {
        var imageName = "sunny"
        var tintColor = UIColor.red
        
        switch weather {
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
        
        self.WeatherImageView.image = UIImage(named: imageName)
        self.WeatherImageView.tintColor = tintColor
        self.maxTempLabel.text = String(max)
        self.minTempLabel.text = String(min)
        self.indicator.stopAnimating()
    }
}


