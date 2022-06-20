//
//  WeatherCacheManager.swift
//  wanted_pre_onboarding_kimkirim
//
//  Created by 김기림 on 2022/06/21.
//

import UIKit

class WeatherCacheManager {
    static let shared = WeatherCacheManager()
    private init() {}

    private var storage: [CityList: WeatherData] = [:]
    
    func getCachedData(city: CityList) -> WeatherData? {
        if (storage[city] != nil) {
            return storage[city]
        }
        return nil
    }
    
    func addData(city: CityList, data: WeatherData) {
        storage.updateValue(data, forKey: city)
    }
    
    func removeAll() {
        storage.removeAll()
    }
}
