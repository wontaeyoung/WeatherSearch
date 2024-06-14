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
    let searchNewCityEvent = PublishRelay<City>()
  }
  
  struct Output {
    let showError: PublishRelay<DomainError>
    let city: PublishRelay<City>
    let currentWeather: PublishRelay<Weather>
    let weathers3H: PublishRelay<[Weather]>
    let weathers5D: PublishRelay<[Weather]>
  }
  
  // MARK: - Property
  let disposeBag = DisposeBag()
  private let currentCity = PublishRelay<City>()
  
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
    let weathers3H = PublishRelay<[Weather]>()
    let weathers5D = PublishRelay<[Weather]>()
    
    /// 현재 도시가 변경되면 새로운 날씨 요청
    currentCity
      .withUnretained(self)
      .flatMap { owner, city in
        return owner.weatherRepository.fetchWeatherForecast(cityID: city.id)
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
    
    /// 2일간의 날씨만 필터링
    weathers
      .map {
        $0.filter {
          DateManager.shared.isToday($0.date) || DateManager.shared.isTomorrow($0.date)
        }
      }
      .bind(to: weathers3H)
      .disposed(by: disposeBag)
    
    /// 정오 기준으로 일일 날씨 필터링
    weathers
      .map {
        $0.filter {
          DateManager.shared.isDate(with: $0.date, by: .hour, equalTo: 12)
        }
      }
      .bind(to: weathers5D)
      .disposed(by: disposeBag)
    
    input.viewDidLoadEvent
      .map { City.defaultValue }
      .bind(to: currentCity)
      .disposed(by: disposeBag)
    
    input.searchNewCityEvent
      .bind(to: currentCity)
      .disposed(by: disposeBag)
      
    return Output(
      showError: showError,
      city: currentCity,
      currentWeather: currentWeather,
      weathers3H: weathers3H,
      weathers5D: weathers5D
    )
  }
}
