//
//  WeatherRepositoryImpl.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

import RxSwift

final class WeatherRepositoryImpl: WeatherRepository {
  
  private let service: HTTPService
  
  init(service: HTTPService) {
    self.service = service
  }
  
  func fetchWeatherForecast(cityID: Int) -> Single<Forecast> {
    let router = WeatherRouter.forecast(cityID: cityID)
    
    return service.callRequest(with: router, of: ForecastResponseDTO.self)
      .catch { .error(HTTPStatusError.toDomain($0)) }
      .map { $0.toEntity }
  }
}
