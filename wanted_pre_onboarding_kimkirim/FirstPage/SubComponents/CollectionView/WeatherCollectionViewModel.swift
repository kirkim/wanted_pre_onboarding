//
//  WeatherCollectionViewModel.swift
//  wanted_pre_onboarding_kimkirim
//
//  Created by 김기림 on 2022/06/20.
//

import Foundation

struct WeatherCollectionViewModel {
    private let model: WeatherCollectionModel
    
    init(_ model: WeatherCollectionModel) {
        self.model = model
    }
    
    func getCellCount() -> Int {
        return model.getCellCount()
    }
    
    func getCellData(indexPath: IndexPath, completion: @escaping (WeatherCellData?) -> ()) {
        return model.getCellData(indexPath: indexPath, completion: completion)
    }
    
    func getDetailWeatherData(indexPath: IndexPath) -> WeatherDetailData? {
        return model.getDetailWeatherData(indexPath: indexPath)
    }
}
