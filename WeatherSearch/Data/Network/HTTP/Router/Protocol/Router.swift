//
//  Router.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

import Foundation
import Alamofire

protocol Router: URLRequestConvertible {
  
  var method: HTTPMethod { get }
  var baseURL: String { get }
  var path: String { get }
  var parameters: Parameters { get }
}

extension Router {
  func asURLRequest() throws -> URLRequest {
    guard let url = URL(string: baseURL + path) else { throw HTTPError.requestFailed }
    
    let request = URLRequest(url: url).applied {
      $0.httpMethod = method.rawValue
    }
    
    return try URLEncoding.default.encode(request, with: parameters)
  }
}
