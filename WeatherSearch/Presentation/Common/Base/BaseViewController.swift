//
//  BaseViewController.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
  
  var disposeBag = DisposeBag()
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setHierarchy() { }
  func setConstraint() { }
  func bind() { }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    
    setHierarchy()
    setConstraint()
    bind()
  }
}
