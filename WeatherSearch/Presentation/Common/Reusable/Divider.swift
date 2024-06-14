//
//  Divider.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

import UIKit
import SnapKit

final class Divider: BaseView {
  override func setConstraint() {
    snp.makeConstraints { make in
      make.height.equalTo(1)
    }
  }
  
  override func setAttribute() {
    backgroundColor = .lightGray
  }
}
