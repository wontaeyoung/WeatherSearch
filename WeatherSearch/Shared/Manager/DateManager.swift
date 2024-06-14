//
//  DateManager.swift
//  WeatherSearch
//
//  Created by 원태영 on 6/14/24.
//

import Foundation

final class DateManager {
  
  static let shared = DateManager()
  private init() { }
  
  private let locale = Locale(identifier: "ko_KR")
  private let timezone = TimeZone(identifier: "ko_KR")
  
  private lazy var dateFormatter = DateFormatter().configured {
    $0.locale = locale
    $0.timeZone = timezone ?? .autoupdatingCurrent
  }
  
  private lazy var calendar = Calendar.current.applied {
    $0.locale = locale
    $0.timeZone = timezone ?? .autoupdatingCurrent
  }
}

// MARK: - Date Formatting
extension DateManager {
  
  func unixDateToString(with interval: TimeInterval, format: Format) -> String {
    dateFormatter.dateFormat = format.format
    
    return dateFormatter.string(from: interval.date)
  }
  
  func startOfDay(when date: Date) -> Date {
    return calendar.startOfDay(for: date)
  }
  
  func isToday(_ date: Date) -> Bool {
    let todayStart = startOfDay(when: Date())
    let todayEnd = calendar.date(byAdding: .day, value: 1, to: todayStart) ?? Date()
    
    return date >= todayStart && date < todayEnd
  }
  
  enum Format: String {
    case HHHour = "HH시"
    case EEE = "EEE"
    
    var format: String {
      return self.rawValue
    }
  }
}
