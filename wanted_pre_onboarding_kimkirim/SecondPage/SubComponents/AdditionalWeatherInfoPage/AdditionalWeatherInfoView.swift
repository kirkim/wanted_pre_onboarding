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

class AdditionalWeatherInfoView: UIView {
    private var viewModel:AdditionalWeatherInfoViewModel?
    
    private let horizonButtonStackView = UIStackView()
    private let temperatureSlotButton = UIButton()
    private let etcSlotButton = UIButton()
    
    private let stickView = UIView()
    
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
        horizonButtonStackView.axis = .horizontal
        horizonButtonStackView.distribution = .fillEqually
        
        contentsStackView.axis = .horizontal
        contentsStackView.distribution = .fillEqually
        contentsStackView.backgroundColor = .white.withAlphaComponent(0.5)

        temperatureSlotButton.setTitle("온도", for: .normal)
        etcSlotButton.setTitle("기압∙풍송∙습도", for: .normal)
        [temperatureSlotButton, etcSlotButton].forEach {
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        }
        
        temperatureSlotButton.addTarget(self, action: #selector(tempSlotButtonHandler), for: .touchUpInside)
        etcSlotButton.addTarget(self, action: #selector(etcSlotButtonHandler), for: .touchUpInside)
        
        stickView.backgroundColor = .white
        stickView.layer.cornerRadius = 10
    }
    
    @objc private func tempSlotButtonHandler() {
        if (currentInfo != .temperature) {
            currentInfo = .temperature
            UIView.animate(withDuration: 0.3, delay: 0) {
                self.stickView.frame.origin.x -= self.frame.width/2
            }
            self.contentsStackView.frame.origin.x += self.frame.width
        }
    }
    
    @objc private func etcSlotButtonHandler() {
        if (currentInfo != .etc) {
            currentInfo = .etc
            UIView.animate(withDuration: 0.3, delay: 0) {
                self.stickView.frame.origin.x += self.frame.width/2
            }
            self.contentsStackView.frame.origin.x -= self.frame.width
        }
    }
    
    private func layout() {
        [horizonButtonStackView, stickView, contentsStackView].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        let horizonButtonStackViewHeightMultiple = 0.3
        let stickViewHeightMultiple = 0.1
        
        horizonButtonStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        horizonButtonStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        horizonButtonStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        horizonButtonStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: horizonButtonStackViewHeightMultiple).isActive = true
        
        stickView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stickView.topAnchor.constraint(equalTo: horizonButtonStackView.bottomAnchor).isActive = true
        stickView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        stickView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: stickViewHeightMultiple).isActive = true
        
        contentsStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentsStackView.topAnchor.constraint(equalTo: stickView.bottomAnchor).isActive = true
        contentsStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        contentsStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        [temperatureSlotButton, etcSlotButton].forEach {
            horizonButtonStackView.addArrangedSubview($0)
        }
        
        [tempInfoView, etcInfoView].forEach {
            contentsStackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        contentsStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 2).isActive = true
    }
}
