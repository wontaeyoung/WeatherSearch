//
//  Constant.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

enum Constant {
  enum Weather {
    static let celsiusBuffer: Double = 273.15
  }
  
  enum File: String {
    case cityList = "citylist"
  }
  
  enum FileExtension: String {
    case json
  }
}
