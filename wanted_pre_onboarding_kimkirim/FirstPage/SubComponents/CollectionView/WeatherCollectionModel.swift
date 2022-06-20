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
                WeatherCacheManager.shared.addData(city: city, data: data)
                let cellData = self.parcingToCellData(city: city, data: data)
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
    
    func getDetailWeatherData(indexPath: IndexPath) -> WeatherData? {
        let city = cities[indexPath.row]
        return WeatherCacheManager.shared.getCachedData(city: city)
    }
    
    private func parcingToCellData(city: CityList, data: WeatherData) -> WeatherCellData {
        let cellData = WeatherCellData(cityName: city.korean, temperature: data.temperatures.temp, humidity: data.temperatures.humidity, icon: data.weather[0].icon)
        return cellData
    }
}
