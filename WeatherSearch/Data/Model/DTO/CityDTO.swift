//
//  CityDTO.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

struct CityDTO: DTO {
  let id: Int
  let name: String
  let coord: CoordDTO
  
  var toEntity: City {
    return City(
      id: id,
      name: name,
      lat: coord.lat,
      lon: coord.lon
    )
  }
  
  struct CoordDTO: Decodable {
    let lat: Double
    let lon: Double
  }
}
