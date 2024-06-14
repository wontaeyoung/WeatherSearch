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
  private let scrollView = UIScrollView()
  private let contentView = UIView()
  private let paddingView = UIView()
  private let summaryView = WeatherSummaryView()
  
  // MARK: - Property
  let viewModel: WeatherViewModel
  
  // MARK: - Initializer
  init(viewModel: WeatherViewModel) {
    self.viewModel = viewModel
    
    super.init()
  }
  
  // MARK: - Life Cycle
  override func setHierarchy() {
    view.addSubviews(scrollView)
    scrollView.addSubviews(contentView)
    contentView.addSubviews(paddingView)
    paddingView.addSubviews(summaryView)
  }
  
  override func setConstraint() {
    scrollView.snp.makeConstraints { make in
      make.edges.equalTo(view.safeAreaLayoutGuide)
    }
    
    contentView.snp.makeConstraints { make in
      make.width.equalTo(scrollView)
      make.verticalEdges.equalTo(scrollView)
    }
    
    paddingView.snp.makeConstraints { make in
      make.edges.equalTo(contentView.safeAreaLayoutGuide).inset(16)
    }
    
    summaryView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  override func bind() {
    let input = WeatherViewModel.Input()
    let output = viewModel.transform(input: input)
    
    /// 에러 표시
    output.showError
      .drive(with: self) { owner, error in
        owner.showErrorAlert(error: error)
      }
      .disposed(by: disposeBag)
    
    output.city
      .asObservable()
      .bind(to: summaryView.city)
      .disposed(by: disposeBag)
    
    output.currentWeather
      .asObservable()
      .bind(to: summaryView.weather)
      .disposed(by: disposeBag)
    
    input.viewDidLoadEvent.accept(())
  }
}
