//
//  UIViewController+.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

import UIKit

// MARK: - Navigation
extension UIViewController {
  
  func push(_ viewController: UIViewController, animation: Bool = true) {
    navigationController?.pushViewController(viewController, animated: animation)
  }
  
  func pop(animation: Bool = true) {
    navigationController?.popViewController(animated: animation)
  }
  
  func present(_ viewController: UIViewController, style: UIModalPresentationStyle = .automatic, animation: Bool = true) {
    viewController.modalPresentationStyle = style
    GCD.main { [weak self] in
      guard let self else { return }
      navigationController?.present(viewController, animated: animation)
    }
  }
  
  func showAlert(
    title: String,
    message: String,
    okTitle: String? = nil,
    okStyle: UIAlertAction.Style = .default,
    isCancelable: Bool = false,
    completion: (() -> Void)? = nil
  ) {
    var alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
      .setAction(title: okTitle ?? "확인", style: okStyle, completion: completion)
      
    if isCancelable {
      alertController = alertController.setCancelAction()
    }
    
    GCD.main { [weak self] in
      guard let self else { return }
      present(alertController)
    }
  }
  
  func showErrorAlert(error: DomainError, completion: (() -> Void)? = nil) {
    let alertController = UIAlertController(
      title: "오류 발생",
      message: error.alertMessage,
      preferredStyle: .alert
    )
      .setAction(title: "확인", style: .default, completion: completion)
    
    GCD.main { [weak self] in
      guard let self else { return }
      present(alertController)
    }
  }
  
  func hideBackButton() -> Self {
    self.navigationItem.setHidesBackButton(true, animated: false)
    return self
  }
}
