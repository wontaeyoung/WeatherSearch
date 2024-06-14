//
//  UIAlertController+.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

import UIKit

extension UIAlertController {
  func setAction(
    title: String?,
    style: UIAlertAction.Style,
    completion: (() -> Void)? = nil
  ) -> UIAlertController {
    let alertAction = UIAlertAction(title: title, style: style) { _ in
      completion?()
    }
    
    addAction(alertAction)
    
    return self
  }
  
  func setCancelAction() -> UIAlertController {
    return setAction(title: "취소", style: .cancel)
  }
}

