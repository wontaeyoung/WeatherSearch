//
//  WeatherCollectionCell.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

import UIKit
import SnapKit

final class WeatherCollectionCell: BaseCollectionViewCell {
  
  private let timeLabel = WSLabel().configured {
    $0.font = .systemFont(ofSize: 15, weight: .semibold)
    $0.textAlignment = .center
  }
  
  private let iconImageView = IconImageView()
  
  private let temperatureLabel = WSLabel().configured {
    $0.font = .systemFont(ofSize: 15, weight: .bold)
    $0.textAlignment = .center
  }
  
  private lazy var stackView = UIStackView().configured {
    $0.axis = .vertical
    $0.distribution = .fillEqually
    $0.alignment = .fill
    $0.spacing = 20
  }
  
  override func setHierarchy() {
    contentView.addSubviews(stackView)
    stackView.addArrangedSubviews(timeLabel, iconImageView, temperatureLabel)
  }
  
  override func setConstraint() {
    stackView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  func updateUI(with weather: Weather) {
    timeLabel.text = DateManager.shared.toString(from: weather.date, format: .HHHour)
    iconImageView.image = UIImage(named: weather.icon)
    temperatureLabel.text = weather.temp.toTempString
  }
}
