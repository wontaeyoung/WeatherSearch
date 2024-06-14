//
//  GCD.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

import Foundation

struct GCD {
  static func main(work: @escaping () -> Void) {
    DispatchQueue.main.async {
      work()
    }
  }
  
  static func global(work: @escaping () -> Void) {
    DispatchQueue.global().async {
      work()
    }
  }
}

