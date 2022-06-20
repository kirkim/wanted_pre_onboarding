//
//  WheatherAPI.swift
//  wanted_pre_onboarding_kimkirim
//
//  Created by 김기림 on 2022/06/20.
//

import Foundation
//static let schema = "https"
//static let host = "dapi.kakao.com"
//static let path1 = "/v2/local/search/category.json"
//static let path2 = "/v2/local/geo/coord2address.json"
//static let path3 = "/v2/local/search/address.json"
//
//func getLocation(by mapPoint: MTMapPoint) -> URLComponents {
//    var components = URLComponents()
//    components.scheme = LocalAPI.schema
//    components.host = LocalAPI.host
//    components.path = LocalAPI.path1
//
//    components.queryItems = [
//        URLQueryItem(name: "category_group_code", value: "CS2"),
//        URLQueryItem(name: "x", value: "\(mapPoint.mapPointGeo().longitude)"),
//        URLQueryItem(name: "y", value: "\(mapPoint.mapPointGeo().latitude)"),
//        URLQueryItem(name: "radius", value: "500"),
//        URLQueryItem(name: "sort", value: "distance")
//    ]
//
//    return components
//}

class WeatherAPI {
    static let schema = "https"
    static let host = "api.openweathermap.org"
    static let weatherPath = "/data/2.5/weather"
    static let iconPath = "/img/wn/"
    private let API_KEY = "bfb1ec7429aee49a725a5c8b7a708115"
    
    func getWeather(by cityName: CityList) -> URLComponents {
        var components = URLComponents()
        components.scheme = WeatherAPI.schema
        components.host = WeatherAPI.host
        components.path = WeatherAPI.weatherPath
        let cityValue = "\(cityName.value),KR"
        
        components.queryItems = [
            URLQueryItem(name: "q", value: cityValue),
            URLQueryItem(name: "appid", value: API_KEY)
        ]
        
        return components
    }
    
    func getWeatherIcon(by code: String) -> URLComponents {
        let iconCode = "\(code)@2x.png"
        var components = URLComponents()
        components.scheme = WeatherAPI.schema
        components.host = WeatherAPI.host
        components.path = WeatherAPI.iconPath + iconCode
        
        return components
    }
}
