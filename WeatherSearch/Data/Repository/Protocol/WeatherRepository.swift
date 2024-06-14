//
//  WeatherRepository.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

import Foundation
import RxSwift

protocol WeatherRepository {
  func fetchWeatherForecast(cityID: Int) -> Single<Forecast>
}
