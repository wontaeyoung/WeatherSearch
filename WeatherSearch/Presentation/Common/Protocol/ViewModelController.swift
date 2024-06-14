//
//  ViewModelController.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

protocol ViewModelController: AnyObject {
  associatedtype ViewModelType: ViewModel
  
  var viewModel: ViewModelType { get }
}

