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

struct WeatherResponse: Codable {
    let weather_condition: String
    let max_temperature: Int
    let min_temperature: Int
}

class WeatherDetail {
    func yumemiWeather(completion: @escaping(Result<(Int,Int,String),Error>)->()){
        //この関数yumemiWeatherはcompletion引数として持っている。escapingでクロージャ関数が終了した後にも呼び出されることが保証されている。今回はあとからもまた天気を表示してと指令が入るから。(
        //(escapingはクロージャが関数のスコープを脱出する可能性がある場合に必要）
        //意味：completionクロージャは(Result<(Int,Int,String),Error>)型を引数として扱います。成功時には天気情報（String, Int, Int）、失敗時にはエラーが渡される。
        //なぜvoidを使うのか？この関数自体は計算を行わない、＝戻り値がない。天気情報を取得するためだけにある関数である。そのためその処理の結果（コンプレッション）
        
        DispatchQueue.global().async {
            let returnJson = infoWeather(area: "Tokyo", date: "2020-04-01T12:00:00+09:00")
            
            do{
                let encoder = JSONEncoder()//あとでデコードの作業が必要になる
                let jsonData = try encoder.encode(returnJson)
                guard let requestJson = String(data: jsonData , encoding: .utf8)else{
                    completion(.failure(YumemiWeatherError.unknownError))
                    return
                }
                //jsonを使う場合はエラーが発生しやすいのでこまめに使う
                let responseWeatherCondition = try YumemiWeather.syncFetchWeather(requestJson)
                
                guard let yumemiJsonConvert = responseWeatherCondition.data(using: .utf8)else{
                    completion(.failure(YumemiWeatherError.unknownError))
                    return//nilの場合はここで止めるよという意味のreturn
                }
                
                let decoder = JSONDecoder()
                let weatherResponse = try decoder.decode(WeatherResponse.self, from: yumemiJsonConvert)
                // 天気情報取得が成功した場合、completionを通じて天気が通知される。DispatchQueue.main.async を使用して、メインスレッドでコールバックが実行されます。UI（画面）の更新を行うため。
                
                DispatchQueue.main.async {
                                    completion(.success((weatherResponse.max_temperature, weatherResponse.min_temperature,weatherResponse.weather_condition)))
                                }

                
                // 結論。上記の結果をコールバックとして外部に通知するためにcompletionクロージャーが使用されています。
            }catch{
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
