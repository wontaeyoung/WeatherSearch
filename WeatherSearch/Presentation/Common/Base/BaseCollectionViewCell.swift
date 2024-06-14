//
//  BaseCollectionViewCell.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
  
  class var identifier: String {
    return self.description()
  }
  
  init() {
    super.init(frame: .zero)
    
    backgroundColor = .clear
    contentView.backgroundColor = .clear
    
    setHierarchy()
    setConstraint()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setHierarchy() { }
  func setConstraint() { }
}

