//
//  DetailWeatherViewController.swift
//  wanted_pre_onboarding_kimkirim
//
//  Created by 김기림 on 2022/06/21.
//

/// 표시데이터:
/// 도시이름, 날씨 아이콘, 날씨설명, 기압, 풍속,
/// 헌재습도, 최저기온, 최고기온, 현재기온, 체감기온
///

import UIKit

class DetailWeatherViewcontroller: UIViewController {
    private let viewModel: DetailWeatherViewModel
    private let containerStackView = UIStackView()
    
    private let iconImageView = UIImageView()
    private let weatherDiscriptionLabel = UILabel()
    private let cityNameLabel = UILabel()
    private let currentTempLabel = UILabel()
    private let minTempLabel = UILabel()
    private let maxTempLabel = UILabel()
    private let feelsLikeTempLabel = UILabel()
    private let humidityLabel = UILabel()
    private let pressureLabel = UILabel()
    private let windSpeedLabel = UILabel()
    
    init(data: WeatherDetailData) {
        self.viewModel = DetailWeatherViewModel(data)
        super.init(nibName: nil, bundle: nil)
        
        attribute()
        layout()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() {
        viewModel.loadIconImage { image in
            self.iconImageView.image = image
        }
        weatherDiscriptionLabel.text = viewModel.getWeatherDiscription()
        cityNameLabel.text = viewModel.getCityName()
        currentTempLabel.text = viewModel.getCurrentTemp()
        minTempLabel.text = viewModel.getMinTemp()
        maxTempLabel.text = viewModel.getMaxTemp()
        feelsLikeTempLabel.text = viewModel.getFeelsLikeTemp()
        humidityLabel.text = viewModel.getHumidity()
        pressureLabel.text = viewModel.getPressure()
        windSpeedLabel.text = viewModel.getPressure()
    }
    
    private func attribute() {
        self.view.backgroundColor = .white
        
        self.containerStackView.axis = .vertical
        self.containerStackView.distribution = .fillEqually
        
        //temp
        [weatherDiscriptionLabel, cityNameLabel, currentTempLabel, minTempLabel, maxTempLabel, feelsLikeTempLabel, humidityLabel, pressureLabel, windSpeedLabel].forEach {
            $0.textAlignment = .center
            $0.font = .systemFont(ofSize: 24)
        }
    }
    
    private func layout() {
        [containerStackView].forEach {
            self.view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [
            iconImageView, weatherDiscriptionLabel,cityNameLabel,
            currentTempLabel, minTempLabel, maxTempLabel, feelsLikeTempLabel,
            humidityLabel, pressureLabel, windSpeedLabel
        ].forEach {
            self.containerStackView.addArrangedSubview($0)
        }
        
        containerStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        containerStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        containerStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        containerStackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
}
