//
//  SearchCityViewModel.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

import RxSwift
import RxCocoa

final class SearchCityViewModel: ViewModel {
  
  // MARK: - I / O
  struct Input {
    let viewDidLoadEvent = PublishRelay<Void>()
    let query = PublishRelay<String>()
  }
  
  struct Output {
    let showError: Driver<DomainError>
    let filterList: Driver<[City]>
  }
  
  // MARK: - Property
  let disposeBag = DisposeBag()
  private let cityList = BehaviorRelay<[City]>(value: [])
  private let cityRepository: any CityRepository
  
  // MARK: - Initializer
  init(cityRepository: any CityRepository) {
    self.cityRepository = cityRepository
  }
  
  // MARK: - Method
  func transform(input: Input) -> Output {
    
    let showError = PublishRelay<DomainError>()
    let filterList = BehaviorRelay<[City]>(value: cityList.value)
    
    input.query
      .map { $0.lowercased() }
      .withUnretained(self)
      .flatMap { owner, query in
        owner.filterCityList(query: query)
      }
      .bind(to: filterList)
      .disposed(by: disposeBag)
    
    input.viewDidLoadEvent
      .withUnretained(self)
      .flatMap { owner, _ in
        return owner.cityRepository.fetchCities()
          .catch {
            showError.accept(owner.toDomainError($0))
            return .never()
          }
      }
      .bind(to: cityList)
      .disposed(by: disposeBag)
    
    return Output(
      showError: showError.asDriver(onErrorJustReturn: .unknown),
      filterList: filterList.asDriver()
    )
  }
  
  private func filterCityList(query: String) -> Observable<[City]> {
    return query.isEmpty
    ? cityList.asObservable()
    : cityList
      .map {
        $0.filter { return $0.name.lowercased().contains(query) }
      }
  }
}

