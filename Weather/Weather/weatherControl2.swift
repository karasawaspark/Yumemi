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
    func yumemiWeather() async -> Result<(Int,Int,String),Error> {
        let returnJson = infoWeather(area: "Tokyo", date: "2020-04-01T12:00:00+09:00")
        
        do{
            let encoder = JSONEncoder()//あとでデコードの作業が必要になる
            let jsonData = try encoder.encode(returnJson)
            guard let requestJson = String(data: jsonData , encoding: .utf8)else{
                return(.failure(YumemiWeatherError.unknownError))
            }
            //jsonを使う場合はエラーが発生しやすいのでこまめに使う
            let responseWeatherCondition = try await YumemiWeather.asyncFetchWeather(requestJson)
            
            guard let jsonData = responseWeatherCondition.data(using: .utf8)else{
                return(.failure(YumemiWeatherError.unknownError))
            }
            
            let decoder = JSONDecoder()
            let weatherResponse = try decoder.decode(WeatherResponse.self, from: jsonData)
            return .success((weatherResponse.max_temperature,weatherResponse.min_temperature,weatherResponse.weather_condition))
            
        }catch{
            return(.failure(YumemiWeatherError.unknownError))
            //DispatchQueue.main.async {
              //  completion(.failure(error))//
            //}
        }
    }
}
