//
//  City.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

struct City: Entity {
  let id: Int
  let name: String
  let country: String
  let lat: Double
  let lon: Double
  
  static var defaultValue: City {
    return City(
      id: 1839726,
      name: "Asan",
      country: "KR",
      lat: 127.004173,
      lon: 36.783611
    )
  }
}
