//
//  Double+.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

extension Double {
  var asInt: Int {
    return Int(self)
  }
  
  var toCelsius: Double {
    return self - Constant.Weather.celsiusBuffer
  }
}
