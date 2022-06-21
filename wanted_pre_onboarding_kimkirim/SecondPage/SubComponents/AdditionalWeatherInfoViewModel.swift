//
//  ETCWeatherInfoStackViewModel.swift
//  wanted_pre_onboarding_kimkirim
//
//  Created by 김기림 on 2022/06/21.
//

import Foundation

struct AdditionalWeatherInfoViewModel {
    private let data: WeatherDetailData
    
    init(_ data: WeatherDetailData) {
        self.data = data
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
    
    private func parsingTemp(temp: Double) -> String {
        let temp = round((temp - 273.15) * 10) / 10
        let result = String(temp) + "℃"
        return result

    }
}
