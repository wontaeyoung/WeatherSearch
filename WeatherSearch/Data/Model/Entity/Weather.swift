//
//  Weather.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

import Foundation

struct Weather: Entity {
  let temp: Int
  let tempMin: Int
  let tempMax: Int
  let icon: String
  let main: String
  let description: String
  let humidity: Int
  let cloud: Int
  let wind: Double
  let date: Date
  
  static var defaultValue: Weather {
    return Weather(
      temp: 0,
      tempMin: 0,
      tempMax: 0,
      icon: "",
      main: "",
      description: "-",
      humidity: 0,
      cloud: 0,
      wind: 0,
      date: Date()
    )
  }
}
