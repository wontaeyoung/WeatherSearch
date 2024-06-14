//
//  CityRepository.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

import Foundation
import RxSwift

protocol CityRepository {
  func fetchCities() -> Single<[City]>
}
