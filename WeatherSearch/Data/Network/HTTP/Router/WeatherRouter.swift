//
//  WeatherRouter.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

import Alamofire

enum WeatherRouter: Router {
  
  case forecast(cityID: Int)
  
  var method: HTTPMethod {
    return .get
  }
  
  var baseURL: String {
    return "https://api.openweathermap.org/data/2.5"
  }
  
  var path: String {
    switch self {
      case .forecast:
        return "/forecast"
    }
  }
  
  var parameters: Parameters {
    switch self {
      case .forecast(let cityID):
        return [
          HTTPParameter.Key.appID: APIKey.appID,
          HTTPParameter.Key.language: HTTPParameter.Value.languageKR,
          HTTPParameter.Key.cityID: cityID
        ]
    }
  }
}
