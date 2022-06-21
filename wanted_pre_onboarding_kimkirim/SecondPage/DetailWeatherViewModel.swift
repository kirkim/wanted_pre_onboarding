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
    let etcWeatherInfoStackViewModel: AdditionalWeatherInfoViewModel
    
    private let data: WeatherDetailData
    
    init(_ data: WeatherDetailData) {
        etcWeatherInfoStackViewModel = AdditionalWeatherInfoViewModel(data)
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
    
    func getWeatherDiscription() -> String {
        return data.weather.description
    }
}
