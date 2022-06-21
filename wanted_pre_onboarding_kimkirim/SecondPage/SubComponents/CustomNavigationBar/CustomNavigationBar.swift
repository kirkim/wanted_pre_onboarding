//
//  CustomNavigationBar.swift
//  wanted_pre_onboarding_kimkirim
//
//  Created by 김기림 on 2022/06/21.
//

import UIKit

class CustomNavigationBar: UIStackView {
    private let backButton = UIButton()
    var rootViewController: UIViewController?
    
    init() {
        super.init(frame: CGRect.zero)
        
        attribute()
        layout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute() {
        self.axis = .horizontal
        self.distribution = .fill
        
        backButton.setTitle("←", for: .normal)
        backButton.titleLabel?.font = .systemFont(ofSize: 30, weight: .bold)
        backButton.addTarget(self, action: #selector(popUpViewController), for: .touchUpInside)
    }
    
    @objc func popUpViewController() {
        rootViewController?.navigationController?.popViewController(animated: true)
    }
    
    private func layout() {
        let leftPaddingView = UIView()
        
        [leftPaddingView, backButton, UIView()].forEach {
            self.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let leftPaddingMultiple = 0.03
        let backButtonMultiple = 0.1
        
        leftPaddingView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: leftPaddingMultiple).isActive = true
        backButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: backButtonMultiple).isActive = true
    }
}
