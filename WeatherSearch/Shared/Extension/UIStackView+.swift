//
//  UIStackView+.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

import UIKit

extension UIStackView {
  func clear() {
    self.arrangedSubviews.forEach {
      self.removeArrangedSubview($0)
      $0.removeFromSuperview()
    }
  }
  
  func addArrangedSubviews(_ view: UIView...) {
    view.forEach {
      self.addArrangedSubview($0)
    }
  }
}
