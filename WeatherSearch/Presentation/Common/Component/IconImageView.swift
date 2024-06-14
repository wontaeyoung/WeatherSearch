//
//  IconImageView.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

import UIKit
import SnapKit

final class IconImageView: UIImageView {
  
  init() {
    super.init(image: nil)
    
    snp.makeConstraints { make in
      make.size.equalTo(22)
    }
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
