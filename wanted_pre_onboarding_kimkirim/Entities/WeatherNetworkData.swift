//
//  WeatherData.swift
//  wanted_pre_onboarding_kimkirim
//
//  Created by 김기림 on 2022/06/20.
//

// 도시이름: name
// 날씨 아이콘: weather -> icon
// 현재기온: main -> temp
// 체감기온: main -> feels_like
// 헌재습도: main -> humidity
// 최저기온: main -> temp_min
// 최고기온: main -> temp_max
// 기압: main -> pressure
// 풍속: wind -> speed
// 날씨설명: weather -> description

import Foundation

struct WeatherNetworkData: Codable {
    var cityName: String
    var temperatures: Temperatures
    var wind: Wind
    var weather: [Weather]
    
    enum CodingKeys: String, CodingKey {
        case wind, weather
        case cityName = "name"
        case temperatures = "main"
    }
}

struct Temperatures: Codable {
    var temp: Double
    var feelsLike: Double
    var humidity: Double
    var tempMin: Double
    var tempMax: Double
    var pressure: Double
    enum CodingKeys: String, CodingKey {
        case temp, humidity, pressure
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct Weather: Codable {
    var main: String
    var description: String
    var icon: String
}

struct Wind: Codable {
    var speed: Double
}
