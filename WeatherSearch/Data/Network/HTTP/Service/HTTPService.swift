//
//  HTTPService.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

import Alamofire
import RxAlamofire
import RxSwift

final class HTTPService {
  
  private let session = Session()
  
  func callRequest<T: DTO>(with router: Router, of type: T.Type) -> Single<T> {
    return session
      .request(router)
      .rx
      .call(of: T.self)
  }
}
