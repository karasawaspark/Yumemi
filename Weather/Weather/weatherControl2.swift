//
//  weatherControl2.swift
//  Weather
//
//  Created by spark-03 on 2024/01/12.
//

import UIKit
import YumemiWeather
//YumemiWeatherのAPIをインポートした

protocol YumemiDelegate {
    func setWeatherImage(type:String)
    func setErrorMessage(alert:String)
}
/*Delegateを実行するためprotocolを記述（Delegateは別のViewControllerを渡すことができるクラスみたいなもの）
*/

class YumemiTenki {
    var delegate: YumemiDelegate?
    
    func setYumemiWeather() {
        do{
            let responseWeatherStr = try YumemiWeather.fetchWeatherCondition(at: "")
            //ある一定の確率でエラーを出すAPIを読み込んでいる
            self.delegate?.setWeatherImage(type: responseWeatherStr)
        }catch YumemiWeatherError.unknownError{
            self.delegate?.setErrorMessage(alert: "不明なエラーが発生しました")
        }catch let error{
            print(error)
        }
    }
}
