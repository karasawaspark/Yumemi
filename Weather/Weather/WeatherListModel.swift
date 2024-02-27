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

class WeatherDetailList {
    func yumemiWeather() async -> Result<[WeatherResponseList],Error> {
        let returnJson = infoWeatherList(areas: [], date: "2020-04-01T12:00:00+09:00")
    
        do{
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(returnJson)
            guard let requestJson = String(data: jsonData , encoding: .utf8)else{
                return(.failure(YumemiWeatherError.unknownError))
            }

            let responseWeatherCondition = try await YumemiWeather.asyncFetchWeatherList(requestJson)
            print(responseWeatherCondition)
            
            guard let jsonData = responseWeatherCondition.data(using: .utf8)else{
                return(.failure(YumemiWeatherError.unknownError))
            }
            
            let decoder = JSONDecoder()
            let weatherResponseList = try decoder.decode([WeatherResponseList].self, from: jsonData)
            return .success(weatherResponseList)
            
        }catch{
            return(.failure(YumemiWeatherError.unknownError))

        }
    }
}
