//
//  TimeInterval+.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

import Foundation

extension TimeInterval {
  var date: Date {
    return Date(timeIntervalSince1970: self)
  }
}
