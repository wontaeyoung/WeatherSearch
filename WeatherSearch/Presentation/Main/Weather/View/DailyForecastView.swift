//
//  DailyForecastView.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class DailyForecastView: BaseView {
  
  let weathers = BehaviorRelay<[Weather]>(value: [])
  
  // MARK: - UI
  private let cardView = CardView()
  private let containerView = UIView()
  private let titleLabel = UILabel().configured {
    $0.text = "5일간의 일기예보"
    $0.textColor = .lightGray
    $0.font = .systemFont(ofSize: 14, weight: .regular)
  }
  private let divider = Divider()
  private lazy var weatherTableView = UITableView().configured {
    $0.register(WeatherTableCell.self, forCellReuseIdentifier: WeatherTableCell.identifier)
    $0.isScrollEnabled = false
    $0.backgroundColor = .clear
  }
  
  // MARK: - Life Cycle
  override func setHierarchy() {
    addSubviews(cardView)
    cardView.addSubviews(containerView)
    containerView.addSubviews(
      titleLabel,
      divider,
      weatherTableView
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
    
    weatherTableView.snp.makeConstraints { make in
      make.top.equalTo(divider.snp.bottom).offset(8)
      make.horizontalEdges.equalToSuperview()
      make.bottom.equalToSuperview()
    }
  }
  
  override func bind() {
    weathers
      .bind(to: weatherTableView.rx.items(
        cellIdentifier: WeatherTableCell.identifier,
        cellType: WeatherTableCell.self)
      ) { row, weather, cell in
        cell.updateUI(with: weather)
      }
      .disposed(by: disposeBag)
  }
}
