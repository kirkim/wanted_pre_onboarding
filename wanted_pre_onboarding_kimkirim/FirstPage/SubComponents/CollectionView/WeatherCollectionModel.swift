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
    private var datas: [CityList:WeatherData] = [:]
    
    func getCellData(indexPath: IndexPath, completion: @escaping (WeatherCellData?) -> ()) {
        let cityName = cities[indexPath.row]
        
        api.getWeather(by: cityName) { result in
            switch result {
            case .success(let data):
                self.datas.updateValue(data, forKey: cityName)
                let cellData = WeatherCellData(cityName: cityName.korean, temperature: data.temperatures.temp, humidity: data.temperatures.humidity, icon: data.weather[0].icon)
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
        let cityName = cities[indexPath.row]
        return datas[cityName]
    }
}
