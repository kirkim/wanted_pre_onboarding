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
    
    private let customNavigationBar = CustomNavigationBar()
    private let iconImageView = UIImageView()
    private let weatherDiscriptionLabel = UILabel()
    private let cityNameLabel = UILabel()
    private let currentTempLabel = UILabel()
    
    private let etcWeatherInfoView = AdditionalWeatherInfoView()
    
    init(data: WeatherDetailData) {
        viewModel = DetailWeatherViewModel(data)
        super.init(nibName: nil, bundle: nil)
        
        attribute()
        layout()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() {
        etcWeatherInfoView.bind(viewModel.etcWeatherInfoStackViewModel)
        viewModel.loadIconImage { [weak self] image in
            self?.iconImageView.image = image
        }
        weatherDiscriptionLabel.text = viewModel.getWeatherDiscription()
        cityNameLabel.text = viewModel.getCityName()
        currentTempLabel.text = viewModel.getCurrentTemp()
    }
    
    private func attribute() {
        view.backgroundColor = UIColor(displayP3Red: 53/256, green: 119/256, blue: 207/256, alpha: 1)
        
        customNavigationBar.rootViewController = self
        
        iconImageView.contentMode = .scaleAspectFill
        
        containerStackView.axis = .vertical
        containerStackView.distribution = .fill
        
        [weatherDiscriptionLabel, currentTempLabel, cityNameLabel].forEach {
            $0.textAlignment = .center
        }
        
        weatherDiscriptionLabel.font = .systemFont(ofSize: 25, weight: .medium)
        currentTempLabel.font = .systemFont(ofSize: 70, weight: .bold)
        cityNameLabel.font = .systemFont(ofSize: 50, weight: .medium)
        
        currentTempLabel.textColor = .white
        cityNameLabel.textColor = .white
        //temp
//        customNavigationBar.backgroundColor = .orange
//        iconImageView.backgroundColor = .red
//        weatherDiscriptionLabel.backgroundColor = .blue
//        currentTempLabel.backgroundColor = .purple
//        cityNameLabel.backgroundColor = .yellow
    }
    
    private func layout() {
        [containerStackView].forEach {
            self.view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let bottomPaddingView = UIView()
        
        [customNavigationBar, iconImageView, weatherDiscriptionLabel,currentTempLabel, cityNameLabel, etcWeatherInfoView, bottomPaddingView].forEach {
            self.containerStackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        containerStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        containerStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        containerStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        containerStackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        let customNavigationBarHeightMultiple = 0.05
        let weatherDiscriptionHeightMultiple = 0.05
        let currentTemperatureLabelHeightMultiple = 0.15
        let cityNameLabelHeightMultiple = 0.15
        let etcWeatherInfoViewHeightMultiple = 0.2
        let bottomPaddingMultiple = 0.1
        
        let totalHeightAnchor = view.safeAreaLayoutGuide.heightAnchor
        
        customNavigationBar.heightAnchor.constraint(equalTo: totalHeightAnchor, multiplier: customNavigationBarHeightMultiple).isActive = true
        weatherDiscriptionLabel.heightAnchor.constraint(equalTo: totalHeightAnchor, multiplier: weatherDiscriptionHeightMultiple).isActive = true
        currentTempLabel.heightAnchor.constraint(equalTo: totalHeightAnchor, multiplier: currentTemperatureLabelHeightMultiple).isActive = true
        cityNameLabel.heightAnchor.constraint(equalTo: totalHeightAnchor, multiplier: cityNameLabelHeightMultiple).isActive = true
        etcWeatherInfoView.heightAnchor.constraint(equalTo: totalHeightAnchor, multiplier: etcWeatherInfoViewHeightMultiple).isActive = true
        bottomPaddingView.heightAnchor.constraint(equalTo: totalHeightAnchor, multiplier: bottomPaddingMultiple).isActive = true
    }
    
    private func temperatureLayout() {
        
    }
}
