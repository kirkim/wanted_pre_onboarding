//
//  WeatherCollectionModel.swift
//  wanted_pre_onboarding_kimkirim
//
//  Created by 김기림 on 2022/06/20.
//

import Foundation

class WeatherCollectionModel {
    
    private let api = WeatherNetwork.shared
    private let cities = CityList.allCases
    
    func getCellData(indexPath: IndexPath, completion: @escaping (WeatherCellData?) -> ()) {
        let city = cities[indexPath.row]
        let cachedData = WeatherCacheManager.shared.getCachedData(city: city)
        if (cachedData != nil) {
            let cellData = self.parcingToCellData(city: city, data: cachedData!)
            completion(cellData)
            return
        }
        api.getWeather(by: city) { result in
            switch result {
            case .success(let data):
                let detailData = WeatherDetailData(cityName: city, temperatures: data.temperatures, wind: data.wind, weather: data.weather[0])
                WeatherCacheManager.shared.addData(city: city, data: detailData)
                let cellData = self.parcingToCellData(city: city, data: detailData)
                completion(cellData)
            case .failure(let error):
                print(error)
                completion(nil)
            }
        }
    }
    
    func getCellCount() -> Int {
        return cities.count
    }
    
    func getDetailWeatherData(indexPath: IndexPath) -> WeatherDetailData? {
        let city = cities[indexPath.row]
        return WeatherCacheManager.shared.getCachedData(city: city)
    }
    
    private func parcingToCellData(city: CityList, data: WeatherDetailData) -> WeatherCellData {
        let cellData = WeatherCellData(cityName: city.korean, temperature: data.temperatures.temp, humidity: data.temperatures.humidity, icon: data.weather.icon)
        return cellData
    }
}
