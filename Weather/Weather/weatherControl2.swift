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
}
//Delegateを実行するためprotocolを記述
//setWeatherImageを実行


class YumemiTenki {
    
    var delegate: YumemiDelegate?
    
    func setYumemiWeather(){
        let responseWeatherStr = YumemiWeather.fetchWeatherCondition()
        delegate?.setWeatherImage(type: responseWeatherStr)
/*処理を任されるクラス
 
*/
        
    }
}
