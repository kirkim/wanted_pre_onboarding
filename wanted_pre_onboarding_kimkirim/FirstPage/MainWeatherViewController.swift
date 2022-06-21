//
//  MainWeatherViewController.swift
//  wanted_pre_onboarding_kimkirim
//
//  Created by 김기림 on 2022/06/20.
//

import UIKit

class MainWeatherViewController: UIViewController {
    private let containerStackView = UIStackView()
    private let titleLabel = UILabel()
    private let collectionView = WeatherCollectionView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
}

//MARK: - attribute, layout function
extension MainWeatherViewController {
    private func attribute() {
        self.view.backgroundColor = UIColor(displayP3Red: 53/256, green: 119/256, blue: 207/256, alpha: 1)
        
        containerStackView.axis = .vertical
        containerStackView.distribution = .fill
        
        titleLabel.text = "날씨 앱"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 35, weight: .bold)
        
        collectionView.customDelegate = self
        // temp
//        containerStackView.backgroundColor = .blue
//        titleLabel.backgroundColor = .green
    }
    
    private func layout() {
        [titleLabel, collectionView].forEach {
            containerStackView.addArrangedSubview($0)
        }
        view.addSubview(containerStackView)
        
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        containerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        containerStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        containerStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        containerStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
}

extension MainWeatherViewController: WeatherCollectionViewDelegate {
    func weatherCollectionView(didSelectItemAt indexPath: IndexPath, _ data: WeatherDetailData?) {
        if (data != nil) {
            let presentVC = DetailWeatherViewcontroller(data: data!)
            self.navigationController?.pushViewController(presentVC, animated: true)
        }
    }
}
