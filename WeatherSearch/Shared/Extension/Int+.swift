//
//  Int+.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

import Foundation

extension Int {
  var toInterval: TimeInterval {
    return TimeInterval(self)
  }
  
  var toTempString: String {
    return "\(self)°"
  }
}
