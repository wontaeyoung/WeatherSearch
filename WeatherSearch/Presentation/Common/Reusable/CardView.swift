//
//  CardView.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

import UIKit
import SnapKit

final class CardView: BaseView {
  
  private let containerView = UIView()
  
  override func setHierarchy() {
    addSubviews(containerView)
  }
  
  override func setConstraint() {
    containerView.snp.makeConstraints { make in
      make.edges.equalTo(self).inset(8)
    }
  }
  
  override func setAttribute() {
    self.configure {
      $0.clipsToBounds = true
      $0.layer.cornerRadius = 12
    }
  }
}
