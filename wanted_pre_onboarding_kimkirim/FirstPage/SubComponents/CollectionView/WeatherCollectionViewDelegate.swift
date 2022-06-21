//
//  WeatherCollectionViewDelegate.swift
//  wanted_pre_onboarding_kimkirim
//
//  Created by 김기림 on 2022/06/21.
//

import Foundation

protocol WeatherCollectionViewDelegate {
    func weatherCollectionView(didSelectItemAt indexPath: IndexPath, _ data: WeatherDetailData?)
}
