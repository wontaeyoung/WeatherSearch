//
//  WeatherDTO.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

import Foundation

struct WeatherDTO: DTO {
  let dt: Int
  let main: MainDTO
  let weather: [WeatherInfoDTO]
  let clouds: CloudDTO
  let wind: WindDTO
  
  var toEntity: Weather {
    let weatherInfo: WeatherInfoDTO = weather.first ?? .defaultValue
    
    return Weather(
      temp: main.temp.toCelsius.asInt,
      tempMin: main.temp_min.toCelsius.asInt,
      tempMax: main.temp_max.toCelsius.asInt,
      icon: weatherInfo.icon,
      description: weatherInfo.description,
      humidity: main.humidity,
      cloud: clouds.all,
      wind: wind.speed,
      date: Date(timeIntervalSince1970: dt.toInterval)
    )
  }
  
  struct MainDTO: Decodable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Int
  }

  struct WeatherInfoDTO: Decodable {
    let main: String
    let description: String
    let icon: String
    
    static var defaultValue: WeatherInfoDTO {
      return WeatherInfoDTO(
        main: "",
        description: "-",
        icon: ""
      )
    }
  }

  struct CloudDTO: Decodable {
    let all: Int
  }

  struct WindDTO: Decodable {
    let speed: Double
  }
}
