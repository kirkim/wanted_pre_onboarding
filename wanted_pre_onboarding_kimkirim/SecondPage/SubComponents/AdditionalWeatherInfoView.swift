//
//  ETCWeatherInfoStackView.swift
//  wanted_pre_onboarding_kimkirim
//
//  Created by 김기림 on 2022/06/21.
//

import UIKit

enum CurrentInfo {
    case temperature
    case etc
}

class AdditionalWeatherInfoView: UIStackView {
    private var viewModel:AdditionalWeatherInfoViewModel?
    
    private let horizonButtonStackView = UIStackView()
    private let temperatureSlotButton = UIButton()
    private let etcSlotButton = UIButton()
    
    private let contentsStackView = UIStackView()
    private let tempInfoView = TemperatureInfoSlotView()
    private let etcInfoView = ETCInfoSlotView()
    
    private var currentInfo: CurrentInfo = .temperature
    
    init() {
        super.init(frame: CGRect.zero)
        
        attribute()
        layout()
    }
    
    func bind(_ viewModel: AdditionalWeatherInfoViewModel) {
        self.viewModel = viewModel
        tempInfoView.setData(viewModel.getMinTemp(), viewModel.getMaxTemp(), viewModel.getFeelsLikeTemp())
        etcInfoView.setData(viewModel.getHumidity(), viewModel.getPressure(), viewModel.getWindSpeed())
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute() {
        self.axis = .vertical
        self.distribution = .fillEqually
        
        horizonButtonStackView.axis = .horizontal
        horizonButtonStackView.distribution = .fillEqually
        
        contentsStackView.axis = .horizontal
        contentsStackView.distribution = .fillEqually
        
        temperatureSlotButton.setTitle("온도", for: .normal)
        etcSlotButton.setTitle("기압∙풍송∙습도", for: .normal)
        [temperatureSlotButton, etcSlotButton].forEach {
            $0.setTitleColor(.black, for: .normal)
        }
        
        temperatureSlotButton.addTarget(self, action: #selector(tempSlotButtonHandler), for: .touchUpInside)
        etcSlotButton.addTarget(self, action: #selector(etcSlotButtonHandler), for: .touchUpInside)
        
        //temp
        contentsStackView.backgroundColor = .brown
    }
    
    @objc private func tempSlotButtonHandler() {
        if (currentInfo != .temperature) {
            currentInfo = .temperature
            self.contentsStackView.frame.origin.x += self.frame.width
        }
    }
    
    @objc private func etcSlotButtonHandler() {
        if (currentInfo != .etc) {
            currentInfo = .etc
            self.contentsStackView.frame.origin.x -= self.frame.width
        }
    }
    
    private func layout() {
        [horizonButtonStackView, contentsStackView].forEach {
            self.addArrangedSubview($0)
            translatesAutoresizingMaskIntoConstraints = false
        }
        
        [temperatureSlotButton, etcSlotButton].forEach {
            horizonButtonStackView.addArrangedSubview($0)
        }
        
        [tempInfoView, etcInfoView].forEach {
            contentsStackView.addArrangedSubview($0)
            translatesAutoresizingMaskIntoConstraints = false
        }
        
        contentsStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 2).isActive = true
    }
}
