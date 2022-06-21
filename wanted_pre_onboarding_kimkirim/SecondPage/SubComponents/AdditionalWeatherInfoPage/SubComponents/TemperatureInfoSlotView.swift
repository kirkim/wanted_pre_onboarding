//
//  InfoStackView.swift
//  wanted_pre_onboarding_kimkirim
//
//  Created by 김기림 on 2022/06/21.
//

import UIKit

class TemperatureInfoSlotView: UIStackView {
    private let minTempView = InfoView()
    private let maxTempView = InfoView()
    private let feelsLikeTempView = InfoView()
    
    init() {
        super.init(frame: CGRect.zero)
        
        attribute()
        layout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(_ minTemp: String, _ maxTemp: String, _ feelsLikeTemp: String) {
        minTempView.setTitle(description: "최저온도", data: minTemp)
        maxTempView.setTitle(description: "최고온도", data: maxTemp)
        feelsLikeTempView.setTitle(description: "체감온도", data: feelsLikeTemp)
    }
    
    private func attribute() {
        self.axis = .horizontal
        self.distribution = .fillEqually
    }
    
    private func layout() {
        [minTempView, maxTempView, feelsLikeTempView].forEach {
            self.addArrangedSubview($0)
        }
    }
}
