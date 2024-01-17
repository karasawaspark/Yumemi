//
//  weatherControl2.swift
//  Weather
//
//  Created by spark-03 on 2024/01/12.
//

import UIKit
import YumemiWeather
import Foundation
//YumemiWeatherのAPIをインポートした

struct infoWeather: Codable{
    var area:String;
    var date:String;
}

protocol YumemiDelegate {
    func setWeatherImage(type: String)
    func setErrorMessage(alert: String)
    func setWeatherTempMax(max: Int)
    func setWeatherTempMin(min: Int)
}


class YumemiTenki {
    var delegate: YumemiDelegate?
    
    func setYumemiWeather() {
        do{
            let returnJson = infoWeather(area: "Tokyo", date: "2020-04-01T12:00:00+09:00")
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(returnJson)
            
            guard let requestJson = String(data: jsonData , encoding: .utf8)
                    //jsonを使う場合はエラーが発生しやすいのでこまめに使う
            else{
                return
            }
            
            let responseWeatherCondition = try YumemiWeather.fetchWeather(requestJson)
            guard let yumemiJsonConvert = responseWeatherCondition.data(using: .utf8),
                  let items = try JSONSerialization.jsonObject(with: yumemiJsonConvert, options: []) as? [String: Any],
                  let maxTemp = items["max_temperature"] as? Int,
                  let minTemp = items["min_temperature"] as? Int,
                  let weatherImage = items["weather_condition"] as? String
            else{
                return
            }
            self.delegate?.setWeatherTempMax(max: maxTemp)
            self.delegate?.setWeatherTempMin(min: minTemp)
            self.delegate?.setWeatherImage(type: weatherImage)
        }catch YumemiWeatherError.unknownError{
            self.delegate?.setErrorMessage(alert: "不明なエラーが発生しました")
        }catch let error{
            print(error)
        }
    }
}

//guared letはエラーにならなかった場合そのまま突っ走るよという。もしエラーが出た場合はreturnで処理を終わらせて、行き止まりにさせてしまうもの。(if letと似ている)

