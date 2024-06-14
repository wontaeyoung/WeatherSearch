//
//  ForecastResponseDTO.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

struct ForecastResponseDTO: DTO {
  let cnt: Int
  let city: CityDTO
  let list: [WeatherDTO]
  
  var toEntity: Forecast {
    return Forecast(
      city: city.toEntity,
      weathers: list.map { $0.toEntity }
    )
  }
}
