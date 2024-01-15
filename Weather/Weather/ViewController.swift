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
    func setErrorMessage(alert: String) {
        let alertController = UIAlertController(title: alert, message: "エラー", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "閉じる", style: .default, handler: nil))
        present(alertController, animated: false, completion: nil)
    }
    
/*
 1行目,alertControllerにダイアログボックスの情報を記載（preferredStyleとは・・・？）
 2行目,次のアクションを記載（今回のケースは"閉じる"）
 3行目,表示アニメーション形式を記載
 ※titleはダイアログに入る文言が入るが、引数をそのまま入力できる。
 ※handlerはフォントのようなレイアウトではなく、関数で置き換えられるような機能的な情報を追加する際に使う。特にない場合はnilを使う
 */
    
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
