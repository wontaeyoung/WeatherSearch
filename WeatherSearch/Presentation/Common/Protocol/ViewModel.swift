//
//  ViewModel.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

import RxSwift

protocol ViewModel: AnyObject {
  associatedtype Input
  associatedtype Output
  
  var disposeBag: DisposeBag { get }
  
  func transform(input: Input) -> Output
}

extension ViewModel {
  func toDomainError(_ error: Error) -> DomainError {
    return error as? DomainError ?? .unknown
  }
}
