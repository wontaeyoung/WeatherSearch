//
//  WeatherSummaryView.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class WeatherSummaryView: BaseView {
  
  let city = PublishRelay<City>()
  let weather = PublishRelay<Weather>()
  
  // MARK: - UI
  private let cityNameLabel = WSLabel().configured {
    $0.font = .systemFont(ofSize: 32, weight: .semibold)
    $0.textAlignment = .center
  }
  
  private let temperatureLabel = WSLabel().configured {
    $0.font = .systemFont(ofSize: 80, weight: .semibold)
    $0.textAlignment = .center
  }
  
  private let weatherDescriptionLabel = WSLabel().configured {
    $0.font = .systemFont(ofSize: 20, weight: .semibold)
    $0.textAlignment = .center
  }
  
  private let temperatureGapLabel = WSLabel().configured {
    $0.font = .systemFont(ofSize: 20, weight: .semibold)
    $0.textAlignment = .center
  }

  // MARK: - Life Cycle
  override func setHierarchy() {
    addSubviews(
      cityNameLabel,
      temperatureLabel,
      weatherDescriptionLabel,
      temperatureGapLabel
    )
  }
  
  override func setConstraint() {
    cityNameLabel.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(24)
      make.horizontalEdges.equalToSuperview()
    }
    
    temperatureLabel.snp.makeConstraints { make in
      make.top.equalTo(cityNameLabel.snp.bottom).offset(0)
      make.horizontalEdges.equalToSuperview()
    }
    
    weatherDescriptionLabel.snp.makeConstraints { make in
      make.top.equalTo(temperatureLabel.snp.bottom).offset(0)
      make.horizontalEdges.equalToSuperview()
    }
    
    temperatureGapLabel.snp.makeConstraints { make in
      make.top.equalTo(weatherDescriptionLabel.snp.bottom).offset(6)
      make.horizontalEdges.equalToSuperview()
    }
  }
  
  override func bind() {
    city
      .map { $0.name }
      .bind(to: cityNameLabel.rx.text)
      .disposed(by: disposeBag)
    
    weather
      .map { $0.temp.toTempString }
      .bind(to: temperatureLabel.rx.text)
      .disposed(by: disposeBag)
    
    weather
      .map { $0.description }
      .bind(to: weatherDescriptionLabel.rx.text)
      .disposed(by: disposeBag)
    
    weather
      .map { "최고 : \($0.tempMax.toTempString) | 최저 : \($0.tempMin.toTempString)" }
      .bind(to: temperatureGapLabel.rx.text)
      .disposed(by: disposeBag)
  }
}
