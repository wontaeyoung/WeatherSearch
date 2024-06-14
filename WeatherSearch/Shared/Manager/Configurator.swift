//
//  Configurator.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

import Foundation

protocol Configurator { }

extension Configurator where Self: Any {
  
  mutating func apply(_ apply: (inout Self) -> Void) {
    apply(&self)
  }
  
  func applied(_ apply: (inout Self) -> Void) -> Self {
    var configurableSelf = self
    apply(&configurableSelf)
    
    return configurableSelf
  }
}

extension Configurator where Self: AnyObject {
  
  func configure(_ apply: (Self) -> Void) {
    apply(self)
  }
  
  func configured(_ apply: (Self) -> Void) -> Self {
    apply(self)
    return self
  }
}

extension NSObject: Configurator { }
extension Array: Configurator { }
extension Dictionary: Configurator { }
extension Set: Configurator { }
