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
    
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true,completion: nil)
    }
}

/*
 特に指示を与えなくても、２つ目の画面を閉じるたら１つ目の画面が自然と出てくる仕様になっている。そのため今回の課題は、
 ①ボタンを押したら２つ目の画面を閉じる。（自動的に１つ目の画面に遷移する）
 ②１つ目の画面は画面が表示したら２つ目の画面に遷移するように指示を与える（ViewDidApperを使用）。
 ③２つ目の画面に遷移。ボタンを押したら〜、、
 という流れが完成する
 */

