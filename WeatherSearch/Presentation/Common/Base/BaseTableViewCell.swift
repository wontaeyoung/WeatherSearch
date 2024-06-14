//
//  BaseTableViewCell.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
  
  class var identifier: String {
    return self.description()
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
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
