//
//  WSLabel.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

import UIKit

final class WSLabel: UILabel {
  public init(text: String? = nil) {
    super.init(frame: .zero)
    
    self.textColor = .white
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
