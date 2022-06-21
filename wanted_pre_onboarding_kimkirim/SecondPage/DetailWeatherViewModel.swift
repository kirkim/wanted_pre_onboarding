//
//  DetailWeatherViewModel.swift
//  wanted_pre_onboarding_kimkirim
//
//  Created by 김기림 on 2022/06/21.
//

/// 데이터:
/// 도시이름, 날씨 아이콘, 날씨설명, 기압, 풍속,
/// 헌재습도, 최저기온, 최고기온, 현재기온, 체감기온
///


import Foundation
import UIKit

class DetailWeatherViewModel {
    private let data: WeatherDetailData
    
    init(_ data: WeatherDetailData) {
        self.data = data
        print(data)
    }
    
    func getCityName() -> String {
        return data.cityName.korean
    }
    
    func loadIconImage(completion: @escaping (UIImage) -> ()) {
        WeatherNetwork.shared.getIconImage(by: data.weather.icon) { result in
            switch result {
            case .success(let image):
                completion(image)
            case .failure(let error):
                print("fail loading image: ", error)
                completion(UIImage())
            }
        }
    }
    
    private func parsingTemp(temp: Double) -> String {
        let temp = round((temp - 273.15) * 10) / 10
        let result = String(temp) + "℃"
        return result

    }
    
    func getCurrentTemp() -> String {
        return parsingTemp(temp: data.temperatures.temp)
    }
    
    func getMinTemp() -> String {
        return parsingTemp(temp: data.temperatures.tempMin)
    }
    
    func getMaxTemp() -> String {
        return parsingTemp(temp: data.temperatures.tempMax)
    }
    
    func getFeelsLikeTemp() -> String {
        return parsingTemp(temp: data.temperatures.feelsLike)
    }
    
    func getHumidity() -> String {
        let result = String(Int(data.temperatures.humidity)) + "%"
        return result
    }
    
    func getPressure() -> String {
        let result = String(Int(data.temperatures.pressure)) + "hPa"
        return result
    }
    
    func getWindSpeed() -> String {
        let result = String(round(data.wind.speed * 10) / 10) + "m/s"
        return result
    }
    
    func getWeatherDiscription() -> String {
        return data.weather.description
    }
}
