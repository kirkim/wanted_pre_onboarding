//
//  WeatherCollectionViewCell.swift
//  wanted_pre_onboarding_kimkirim
//
//  Created by 김기림 on 2022/06/20.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    static let identity = "WeatherCollectionViewCell"
    
    // Container StackView
    private let verticalStackView = UIStackView()
    private let horizonStackView = UIStackView()
    
    // Contents
    private let iconImageView = UIImageView()
    private let cityNameLabel = UILabel()
    private let temperatureLabel = UILabel()
    private let humidityLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(data: WeatherCellData) {
        cityNameLabel.text = data.cityName
        temperatureLabel.text = parsingToCelsiusString(temp: data.temperature) + "℃"
        humidityLabel.text = String(Int(data.humidity)) + "%"
        WeatherNetwork.shared.getIconImage(by: data.icon) { result in
            switch result {
            case .success(let image):
                self.iconImageView.image = image
            case .failure(let error):
                print(error)
            }
        }
    }
}

//MARK: - attribute, layout function
extension WeatherCollectionViewCell {
    private func attribute() {
        contentView.backgroundColor = .brown
        
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .fill
        
        horizonStackView.axis = .horizontal
        horizonStackView.distribution = .fillEqually
        
        [temperatureLabel, humidityLabel, cityNameLabel].forEach {
            $0.textAlignment = .center
        }
        
        //temp
        verticalStackView.backgroundColor = .red
        horizonStackView.backgroundColor = .green
        iconImageView.backgroundColor = .brown
    }
    
    private func parsingToCelsiusString(temp: Double) -> String {
        return String(round((temp - 273.15) * 10) / 10)
    }
    
    private func layout() {
        [verticalStackView].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [temperatureLabel, humidityLabel].forEach {
            horizonStackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        [iconImageView, horizonStackView, cityNameLabel].forEach {
            verticalStackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

        cityNameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        horizonStackView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
