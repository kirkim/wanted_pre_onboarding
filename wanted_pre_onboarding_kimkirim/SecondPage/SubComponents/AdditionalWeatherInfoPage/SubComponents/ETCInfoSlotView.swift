//
//  ETCInfoStackView.swift
//  wanted_pre_onboarding_kimkirim
//
//  Created by 김기림 on 2022/06/21.
//

import UIKit

class ETCInfoSlotView: UIStackView {
    private let humidityView = InfoView()
    private let pressureView = InfoView()
    private let windSpeedView = InfoView()
    
    init() {
        super.init(frame: CGRect.zero)
        
        attribute()
        layout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(_ humidity: String, _ pressure: String, _ windSpeed: String) {
        humidityView.setTitle(description: "습도", data: humidity)
        pressureView.setTitle(description: "기압", data: pressure)
        windSpeedView.setTitle(description: "풍속", data: windSpeed)
    }
    
    private func attribute() {
        self.axis = .horizontal
        self.distribution = .fillEqually
    }
    
    private func layout() {
        [humidityView, pressureView, windSpeedView].forEach {
            self.addArrangedSubview($0)
        }
    }
}
