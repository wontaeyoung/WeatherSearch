//
//  CardView.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

import UIKit
import SnapKit

final class CardView: BaseView {
  override func setAttribute() {
    self.backgroundColor = .black.withAlphaComponent(0.8)
    
    self.configure {
      $0.clipsToBounds = true
      $0.layer.cornerRadius = 12
    }
  }
}
