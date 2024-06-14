//
//  WeatherViewModel.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

import Foundation
import RxSwift
import RxCocoa

final class WeatherViewModel: ViewModel {
  
  // MARK: - I / O
  struct Input {
    let viewDidLoadEvent = PublishRelay<Void>()
  }
  
  struct Output {
    let showError: Driver<DomainError>
    let city: Driver<City>
    let currentWeather: Driver<Weather>
  }
  
  // MARK: - Property
  let disposeBag = DisposeBag()
  private let currentCity = BehaviorRelay<City>(value: .defaultValue)
  
  private let weatherRepository: any WeatherRepository
  
  // MARK: - Initializer
  init(weatherRepository: any WeatherRepository) {
    self.weatherRepository = weatherRepository
  }
  
  // MARK: - Method
  func transform(input: Input) -> Output {
    
    let showError = PublishRelay<DomainError>()
    let weathers = PublishRelay<[Weather]>()
    let currentWeather = PublishRelay<Weather>()
    
    /// 날짜 정렬 후 첫 날씨를 현재 날씨로 설정
    weathers
      .withUnretained(self)
      .flatMap { owner, weathers in
        guard let currentWeather = weathers.first else {
          showError.accept(.invalidRequest)
          return Single<Weather>.never()
        }
        dump(currentWeather)
        return .just(currentWeather)
      }
      .bind(to: currentWeather)
      .disposed(by: disposeBag)
    
    input.viewDidLoadEvent
      .withUnretained(self)
      .flatMap { owner, _ in
        return owner.weatherRepository.fetchWeatherForecast(cityID: owner.currentCity.value.id)
          .catch {
            showError.accept(owner.toDomainError($0))
            return .never()
          }
      }
      .map {
        $0.weathers.sorted { $0.date < $1.date }
      }
      .bind(to: weathers)
      .disposed(by: disposeBag)
      
    return Output(
      showError: showError.asDriver(onErrorJustReturn: .unknown),
      city: currentCity.asDriver(),
      currentWeather: currentWeather.asDriver(onErrorJustReturn: .defaultValue)
    )
  }
}
