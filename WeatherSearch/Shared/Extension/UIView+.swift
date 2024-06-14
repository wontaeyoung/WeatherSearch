//
//  UIView+.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

import UIKit

extension UIView {
  func addSubviews(_ view: UIView...) {
    view.forEach { self.addSubview($0) }
  }
}
