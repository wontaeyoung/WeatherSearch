//
//  Reactive+DataRequest.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

import Alamofire
import RxSwift

extension Reactive where Base: DataRequest {
  func call<T: Decodable>(of type: T.Type) -> Single<T> {
    return Single.create { single in
      let request = base
        .validate()
        .responseDecodable(of: T.self) { response in
          switch response.result {
            case .success(let value):
              single(.success(value))
              
            case .failure(let error):
              let httpError = mapError(error)
              single(.failure(httpError))
          }
        }
      
      return Disposables.create {
        request.cancel()
      }
    }
  }
  
  private func mapError(_ error: AFError) -> HTTPError {
    guard let status = error.responseCode else {
      return .requestFailed
    }
    
    return .unexceptedResponse(status: status)
  }
}
