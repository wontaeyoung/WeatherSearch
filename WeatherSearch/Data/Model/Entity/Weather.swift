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
  let description: String
  let humidity: Int
  let cloud: Int
  let wind: Double
  let date: Date
}
