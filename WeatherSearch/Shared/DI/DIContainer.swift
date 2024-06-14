//
//  DIContainer.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

final class DIContainer {
  
  private init() { }
  
  static let httpService = HTTPService()
  static let jsonService = JsonService()
  static let weatherRepository: any WeatherRepository = WeatherRepositoryImpl(service: httpService)
  static let cityRepository: any CityRepository = CityRepositoryImpl(service: jsonService)
}
