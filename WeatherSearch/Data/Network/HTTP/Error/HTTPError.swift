//
//  HTTPError.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

enum HTTPError: Error {
  typealias HTTPStatus = Int
  
  case requestFailed
  case unexceptedResponse(status: HTTPStatus)
}
