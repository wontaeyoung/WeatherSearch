//
//  CityTableCell.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

import UIKit
import SnapKit

final class CityTableCell: BaseTableViewCell {
  
  // MARK: - UI
  private let containerView = UIView()
  private let nameLabel = UILabel().configured {
    $0.font = .systemFont(ofSize: 16, weight: .bold)
  }
  private let countryLabel = UILabel().configured {
    $0.font = .systemFont(ofSize: 14, weight: .semibold)
  }
  
  // MARK: - Life Cycle
  override func setHierarchy() {
    contentView.addSubviews(containerView)
    containerView.addSubviews(nameLabel, countryLabel)
  }
  
  override func setConstraint() {
    containerView.snp.makeConstraints { make in
      make.edges.equalToSuperview().inset(10)
    }
    
    nameLabel.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.horizontalEdges.equalToSuperview()
    }
    
    countryLabel.snp.makeConstraints { make in
      make.top.equalTo(nameLabel.snp.bottom).offset(4)
      make.horizontalEdges.equalToSuperview()
      make.bottom.equalToSuperview()
    }
  }
  
  func updateUI(with city: City) {
    nameLabel.text = city.name
    countryLabel.text = city.country
  }
}
