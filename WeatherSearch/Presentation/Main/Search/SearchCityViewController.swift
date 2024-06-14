//
//  SearchCityViewController.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SearchCityViewController: BaseViewController, ViewModelController {
  
  // MARK: - UI
  private let searchBar = UISearchBar().configured {
    $0.placeholder = "도시 이름을 검색하세요"
    $0.autocorrectionType = .no
    $0.autocapitalizationType = .none
    $0.spellCheckingType = .no
    $0.backgroundImage = .init()
  }
  
  private let tableView = UITableView().configured {
    $0.register(CityTableCell.self, forCellReuseIdentifier: CityTableCell.identifier)
    $0.keyboardDismissMode = .onDrag
  }
  
  // MARK: - Property
  let viewModel: SearchCityViewModel
  private let selectedCity: PublishRelay<City>
  
  // MARK: - Initializer
  init(viewModel: SearchCityViewModel, selectedCity: PublishRelay<City>) {
    self.viewModel = viewModel
    self.selectedCity = selectedCity
    
    super.init()
  }
  
  // MARK: - Life Cycle
  override func setHierarchy() {
    view.addSubviews(searchBar, tableView)
  }
  
  override func setConstraint() {
    searchBar.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.horizontalEdges.equalToSuperview()
    }
    
    tableView.snp.makeConstraints { make in
      make.top.equalTo(searchBar.snp.bottom).offset(10)
      make.horizontalEdges.equalToSuperview()
      make.bottom.equalTo(view.safeAreaLayoutGuide)
    }
  }
  
  override func bind() {
    let input = SearchCityViewModel.Input()
    let output = viewModel.transform(input: input)
    
    output.showError
      .drive(with: self) { owner, error in
        owner.showErrorAlert(error: error)
      }
      .disposed(by: disposeBag)
    
    output.filterList
      .drive(tableView.rx.items(
        cellIdentifier: CityTableCell.identifier,
        cellType: CityTableCell.self)
      ) { row, item, cell in
        cell.updateUI(with: item)
      }
      .disposed(by: disposeBag)
    
    searchBar.rx.text.orEmpty
      .distinctUntilChanged()
      .bind(to: input.query)
      .disposed(by: disposeBag)
    
    tableView.rx.modelSelected(City.self)
      .bind(to: selectedCity)
      .disposed(by: disposeBag)
    
    selectedCity
      .bind(with: self) { owner, _ in
        owner.pop()
      }
      .disposed(by: disposeBag)
    
    input.viewDidLoadEvent.accept(())
  }
}
