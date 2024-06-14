//
//  BaseView.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

import UIKit

class BaseView: UIView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.backgroundColor = .clear
    
    setHierarchy()
    setConstraint()
    setAttribute()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) BaseView")
  }
  
  func setHierarchy() { }
  func setConstraint() { }
  func setAttribute() { }
}
