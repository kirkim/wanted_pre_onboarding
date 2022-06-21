//
//  WeatherCollectionView.swift
//  wanted_pre_onboarding_kimkirim
//
//  Created by 김기림 on 2022/06/20.
//

import UIKit

class WeatherCollectionView: UICollectionView {
    private let model = WeatherCollectionModel()
    private let viewModel: WeatherCollectionViewModel
    var customDelegate: WeatherCollectionViewDelegate?
    
    init() {
        viewModel = WeatherCollectionViewModel(model)
        super.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute() {
        self.backgroundColor = .clear
        self.collectionViewLayout = createLayout()
        self.dataSource = self
        self.delegate = self
        self.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: WeatherCollectionViewCell.identity)
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }
    
    @objc private func didPullToRefresh() {
        DispatchQueue.global().async {
            WeatherCacheManager.shared.removeAll()
            sleep(1) // 임시로 지연시간 1초 줌
            DispatchQueue.main.async {
                self.reloadData()
                self.refreshControl?.endRefreshing()
            }
        }
    }
    
    private func layout() {
        
    }
}

// MARK: - WeatherCollectionView datasource
extension WeatherCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CityList.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.identity, for: indexPath) as! WeatherCollectionViewCell
        viewModel.getCellData(indexPath: indexPath) { data in
            if (data != nil ) {
                cell.setData(data: data!)
            }
        }
        return cell
    }
}

// MARK: - WeatherCollectionView delegate
extension WeatherCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = viewModel.getDetailWeatherData(indexPath: indexPath)
        customDelegate?.weatherCollectionView(didSelectItemAt: indexPath, data)
    }
}

// MARK: - WeatherCollectionView NSCollectionLayoutSection
extension WeatherCollectionView {
    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/4)), subitem: item, count: 3)
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            return section
        }
    }
}
