//
//  DomainError.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

enum DomainError: Error {
  
  case unknown
  case requestFailed
  case invalidRequest
  case overcall
  case serverError
  
  var alertMessage: String {
    switch self {
      case .unknown:
        return "알 수 없는 문제가 발생했습니다. 문제가 지속되면 고객센터로 문의해주세요."
        
      case .requestFailed:
        return "요청이 실패했습니다. 문제가 지속되면 고객센터로 문의해주세요."
      
      case .invalidRequest:
        return "잘못된 요청이 발생했습니다. 문제가 지속되면 고객센터로 문의해주세요."
        
      case .overcall:
        return "요청이 너무 많습니다. 잠시 후 다시 시도해주세요."
        
      case .serverError:
        return "서버에 문제가 발생했습니다. 잠시 후 다시 시도해주세요."
    }
  }
}
