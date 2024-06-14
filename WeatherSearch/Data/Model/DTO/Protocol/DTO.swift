//
//  DTO.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

protocol DTO: Decodable {
  associatedtype EntityType: Entity
  
  var toEntity: EntityType { get }
}
