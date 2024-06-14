//
//  HTTPStatusError.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

enum HTTPStatusError: Int, Error {
  
  case unknown = 0
  case badRequest = 400
  case unauthorized = 401
  case forbidden = 403
  case notFound = 404
  case overcall = 429
  case serverError = 500
  
  init(_ rawValue: RawValue) {
    self = HTTPStatusError(rawValue: rawValue) ?? .unknown
  }
  
  var statusCode: Int {
    return self.rawValue
  }
}
