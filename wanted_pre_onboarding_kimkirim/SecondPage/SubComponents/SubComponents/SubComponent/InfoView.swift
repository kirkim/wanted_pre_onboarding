//
//  TemperatureView.swift
//  wanted_pre_onboarding_kimkirim
//
//  Created by 김기림 on 2022/06/21.
//

import UIKit

class InfoView: UIStackView {
    private let descriptionLabel = UILabel()
    private let dataLabel = UILabel()
    
    init() {
        super.init(frame: CGRect.zero)
        
        attribute()
        layout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(description: String, data: String) {
        self.descriptionLabel.text = description
        self.dataLabel.text = data
    }
    
    private func attribute() {
        self.axis = .vertical
        self.distribution = .fillEqually
        
        [descriptionLabel, dataLabel].forEach {
            $0.textAlignment = .center
            $0.textColor = .black
        }
        descriptionLabel.font = .systemFont(ofSize: 22, weight: .medium)
        dataLabel.font = .systemFont(ofSize: 22, weight: .medium)
    }
    
    private func layout() {
        [descriptionLabel, dataLabel].forEach {
            self.addArrangedSubview($0)
        }
    }
}
