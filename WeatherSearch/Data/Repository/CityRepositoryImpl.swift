//
//  CityRepositoryImpl.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

import RxSwift

final class CityRepositoryImpl: CityRepository {
  
  private let service: JsonService
  
  init(service: JsonService) {
    self.service = service
  }
  
  func fetchCities() -> Single<[City]> {
    return service.parse(file: .cityList, fileExtension: .json, type: [CityDTO].self)
      .map {
        $0.map { $0.toEntity }
      }
  }
}
