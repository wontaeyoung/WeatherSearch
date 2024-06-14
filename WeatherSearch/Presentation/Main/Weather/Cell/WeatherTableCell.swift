//
//  WeatherTableCell.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

import UIKit
import SnapKit

final class WeatherTableCell: BaseTableViewCell {
  
  private let dayLabel = WSLabel().configured {
    $0.font = .systemFont(ofSize: 15, weight: .semibold)
    $0.textAlignment = .left
  }
  
  private let iconImageView = IconImageView()
  
  private let temperatureGapLabel = WSLabel().configured {
    $0.font = .systemFont(ofSize: 15, weight: .bold)
    $0.textAlignment = .right
  }
  
  override func setHierarchy() {
    contentView.addSubviews(dayLabel, iconImageView, temperatureGapLabel)
  }
  
  override func setConstraint() {
    dayLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview()
      make.verticalEdges.equalToSuperview()
      make.width.equalToSuperview().multipliedBy(0.2)
    }
    
    iconImageView.snp.makeConstraints { make in
      make.leading.equalTo(dayLabel.snp.trailing)
      make.verticalEdges.equalToSuperview()
    }
    
    temperatureGapLabel.snp.makeConstraints { make in
      make.leading.greaterThanOrEqualTo(iconImageView.snp.trailing).offset(20)
      make.verticalEdges.equalToSuperview()
      make.trailing.equalToSuperview()
    }
  }
  
  func updateUI(with weather: Weather) {
    dayLabel.text = DateManager.shared.isToday(weather.date)
    ? "오늘"
    : DateManager.shared.toString(from: weather.date, format: .EEE)
    iconImageView.image = UIImage(named: weather.icon)
    temperatureGapLabel.text = "최소: \(weather.tempMin.toTempString) 최대: \(weather.tempMax.toTempString)"
  }
}

