//
//  HourlyForecastView.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class HourlyForecastView: BaseView {
  
  let weathers = BehaviorRelay<[Weather]>(value: [])
  
  // MARK: - UI
  private let cardView = CardView()
  private let containerView = UIView()
  private let titleLabel = UILabel().configured {
    $0.text = "3시간 간격의 일기예보"
    $0.textColor = .gray
    $0.font = .systemFont(ofSize: 14, weight: .regular)
  }
  private let divider = Divider()
  private lazy var weatherCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).configured {
    $0.register(WeatherCollectionCell.self, forCellWithReuseIdentifier: WeatherCollectionCell.identifier)
  }
  
  private var layout: UICollectionViewFlowLayout {
    let cellSpacing: CGFloat = 10
    
    return UICollectionViewFlowLayout().configured {
      $0.itemSize = CGSize(width: 40, height: 100)
      $0.sectionInset = UIEdgeInsets(top: cellSpacing, left: cellSpacing, bottom: cellSpacing, right: cellSpacing)
      $0.minimumLineSpacing = cellSpacing
      $0.minimumInteritemSpacing = cellSpacing
      $0.scrollDirection = .horizontal
    }
  }
  
  // MARK: - Life Cycle
  override func setHierarchy() {
    addSubviews(cardView)
    cardView.addSubviews(containerView)
    containerView.addSubviews(
      titleLabel,
      divider,
      weatherCollectionView
    )
  }
  
  override func setConstraint() {
    cardView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    containerView.snp.makeConstraints { make in
      make.edges.equalToSuperview().inset(8)
    }
    
    titleLabel.snp.makeConstraints { make in
      make.top.horizontalEdges.equalToSuperview().inset(8)
    }
    
    divider.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(8)
      make.horizontalEdges.equalToSuperview()
    }
    
    weatherCollectionView.snp.makeConstraints { make in
      make.top.equalTo(divider.snp.bottom).offset(8)
      make.horizontalEdges.equalToSuperview()
      make.bottom.equalToSuperview()
    }
  }
  
  override func bind() {
    weathers
      .bind(to: weatherCollectionView.rx.items(
        cellIdentifier: WeatherCollectionCell.identifier,
        cellType: WeatherCollectionCell.self)
      ) { item, weather, cell in
        cell.updateUI(with: weather)
      }
      .disposed(by: disposeBag)
  }
}
