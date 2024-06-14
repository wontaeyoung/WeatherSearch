//
//  WeatherViewController.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class WeatherViewController: BaseViewController, ViewModelController {
  
  // MARK: - UI
  private let backgroundImageView = UIImageView()
  private let alphaView = UIView().configured { $0.backgroundColor = .black.withAlphaComponent(0.5) }
  private let searchBar = UISearchBar()
  private let searchButton = UIButton().configured {
    $0.backgroundColor = .clear
  }
  private let scrollView = UIScrollView()
  private let contentView = UIView()
  private let paddingView = UIView()
  private let summaryView = WeatherSummaryView()
  private let hourlyForecastView = HourlyForecastView()
  private let dailyForecastView = DailyForecastView()
  
  // MARK: - Property
  let viewModel: WeatherViewModel
  private let selectedCity = PublishRelay<City>()
  
  // MARK: - Initializer
  init(viewModel: WeatherViewModel) {
    self.viewModel = viewModel
    
    super.init()
  }
  
  // MARK: - Life Cycle
  override func setHierarchy() {
    view.addSubviews(
      backgroundImageView,
      alphaView,
      searchBar,
      searchButton,
      scrollView
    )
    scrollView.addSubviews(contentView)
    contentView.addSubviews(paddingView)
    paddingView.addSubviews(summaryView)
  }
  
  override func setConstraint() {
    backgroundImageView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    alphaView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    searchBar.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.horizontalEdges.equalToSuperview().inset(20)
    }
    
    searchButton.snp.makeConstraints { make in
      make.edges.equalTo(searchBar)
    }
    
    scrollView.snp.makeConstraints { make in
      make.top.equalTo(searchBar.snp.bottom)
      make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
      make.bottom.equalTo(view.safeAreaLayoutGuide)
    }
    
    contentView.snp.makeConstraints { make in
      make.width.equalTo(scrollView)
      make.verticalEdges.equalTo(scrollView)
    }
    
    paddingView.snp.makeConstraints { make in
      make.edges.equalToSuperview().inset(16)
    }
    
    summaryView.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.horizontalEdges.equalToSuperview()
      make.bottom.equalToSuperview()
    }
  }
  
  override func bind() {
    let input = WeatherViewModel.Input()
    let output = viewModel.transform(input: input)
    
    /// 에러 표시
    output.showError
      .bind(with: self) { owner, error in
        owner.showErrorAlert(error: error)
      }
      .disposed(by: disposeBag)
    
    output.city
      .bind(to: summaryView.city)
      .disposed(by: disposeBag)
    
    output.currentWeather
      .bind(to: summaryView.weather)
      .disposed(by: disposeBag)
    
    output.currentWeather
      .map { $0.main.lowercased() }
      .map { UIImage(named: $0) }
      .bind(to: backgroundImageView.rx.image)
      .disposed(by: disposeBag)
    
    output.weathers3H
      .bind(to: hourlyForecastView.weathers)
      .disposed(by: disposeBag)
    
    output.weathers5D
      .bind(to: dailyForecastView.weathers)
      .disposed(by: disposeBag)
    
    input.viewDidLoadEvent.accept(())
    
    searchButton.rx.tap
      .bind(with: self) { owner, _ in
        owner.showSearchCityView(selectedCity: owner.selectedCity)
      }
      .disposed(by: disposeBag)
    
    selectedCity
      .bind(to: input.searchNewCityEvent)
      .disposed(by: disposeBag)
  }
  
  private func showSearchCityView(selectedCity: PublishRelay<City>) {
    let vm = SearchCityViewModel(cityRepository: DIContainer.cityRepository)
    let vc = SearchCityViewController(viewModel: vm, selectedCity: selectedCity)
      .hideBackTitle()
    
    push(vc)
  }
}
