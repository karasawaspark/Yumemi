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
//Delegateを実行するためprotocolを記述（Delegateは別のViewController渡すことができるクラスみたいなもの）
//setWeatherImageを実行（setWeatherImageというメソッドを実行。別画面のためDelegateを用いている）


class YumemiTenki {
    var delegate: YumemiDelegate?
    
    func setYumemiWeather(){
        let responseWeatherStr = YumemiWeather.fetchWeatherCondition()
        delegate?.setWeatherImage(type: responseWeatherStr)
/*処理を任されるクラス
APIを呼び起こす記述。（responseWeatherStr = YumemiWeather.fetchWeatherStr）
最後の行も決まり文句のようなもの。「delegate?.関数（typeという引数にresponseWeatherConditionが入る）」
*/
        }
}
