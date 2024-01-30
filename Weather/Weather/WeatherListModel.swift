//
//  WeatherListModel.swift
//  Weather
//
//  Created by spark-03 on 2024/01/29.
//

import Foundation
import YumemiWeather

struct infoWeatherList: Codable {
    var areas: [String]
    var date: String
}

struct WeatherResponseList: Codable {
    let area : Area
    let info : WeatherResponse
}
    //WeatherResponseは

class WeatherDetailList {
    func yumemiWeather() async -> Result<[WeatherResponseList],Error> {
        let returnJson = infoWeatherList(areas: [], date: "2020-04-01T12:00:00+09:00")
        //areasに[]を囲うことでAPIに登録されている配列を全て出してくれる
    
        do{
            let encoder = JSONEncoder()//あとでデコードの作業が必要になる
            let jsonData = try encoder.encode(returnJson)
            guard let requestJson = String(data: jsonData , encoding: .utf8)else{
                return(.failure(YumemiWeatherError.unknownError))
            }
            //jsonを使う場合はエラーが発生しやすいのでこまめに使う
            let responseWeatherCondition = try await YumemiWeather.asyncFetchWeatherList(requestJson)
            print(responseWeatherCondition)
            
            guard let jsonData = responseWeatherCondition.data(using: .utf8)else{
                return(.failure(YumemiWeatherError.unknownError))
            }
            
            let decoder = JSONDecoder()
            let weatherResponseList = try decoder.decode([WeatherResponseList].self, from: jsonData)
            return .success(weatherResponseList)
            //weatherResponseListに最高気温、最低気温など全ての情報が入っている
            
        }catch{
            return(.failure(YumemiWeatherError.unknownError))
            //DispatchQueue.main.async {
              //  completion(.failure(error))//
            //}
        }
    }
}
