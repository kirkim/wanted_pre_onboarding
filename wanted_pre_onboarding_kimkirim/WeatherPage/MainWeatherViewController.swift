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
    private let tableView = UITableView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute() {
        containerStackView.axis = .vertical
        containerStackView.distribution = .fill
        
        titleLabel.text = "날씨 정보"
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 25, weight: .medium)
        
        tableView.dataSource = self
        
        // temp
        containerStackView.backgroundColor = .blue
        titleLabel.backgroundColor = .green
        tableView.backgroundColor = .purple
    }
    
    private func layout() {
        [titleLabel, tableView].forEach {
            containerStackView.addArrangedSubview($0)
        }
        view.addSubview(containerStackView)
        
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        containerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        containerStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        containerStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        containerStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
}

extension MainWeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}