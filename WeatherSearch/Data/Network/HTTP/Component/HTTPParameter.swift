//
//  HTTPParameter.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

enum HTTPParameter {
  enum Key {
    static let appID: String = "appid"
    static let language: String = "lang"
    static let cityID: String = "id"
  }
  
  enum Value {
    static let languageKR: String = "kr"
  }
}
