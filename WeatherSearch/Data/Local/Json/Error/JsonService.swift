//
//  JsonService.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

import Foundation
import RxSwift

final class JsonService {
  func parse<T: DTO>(file: Constant.File, fileExtension: Constant.FileExtension, type: T.Type) -> Single<T> {
    return Single.create { single in
      guard 
        let path = Bundle.main.path(forResource: file.rawValue, ofType: fileExtension.rawValue),
        let jsonString = try? String(contentsOfFile: path),
        let jsonData = jsonString.data(using: .utf8),
        let dto = try? JsonCoder.shared.decode(to: T.self, from: jsonData)
      else {
        single(.failure(DomainError.getCityListFailed))
        return Disposables.create()
      }
      single(.success(dto))
      return Disposables.create()
    }
  }
}
