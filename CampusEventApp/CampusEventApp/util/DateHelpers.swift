//
//  DateHelpers.swift
//  CampusEventApp
//
//  Created on 25.05.24.
//

import Foundation

extension Date {
    
    static var shortDateFormatter: DateFormatter {
           let formatter = DateFormatter()
           formatter.dateFormat = "dd.MM.yyyy"
           return formatter
       }
       
       static var timeFormatter: DateFormatter {
           let formatter = DateFormatter()
           formatter.dateFormat = "H:mm 'Uhr'"
           return formatter
       }
       
       static var combinedFormatter: DateFormatter {
           let formatter = DateFormatter()
           formatter.dateFormat = "dd.MM.yyyy,H:mm 'Uhr'"
           return formatter
       }
       
       func descriptiveString(dateStyle: DateFormatter.Style = .short) -> String {
           let formatter = DateFormatter()
           formatter.dateStyle = dateStyle
           let daysBetween = self.daysBetween(date: Date())
           
           if daysBetween == 0 {
               return "Today"
           } else if daysBetween == 1 {
               return "Yesterday"
           } else if daysBetween < 5 {
               let weekdayIndex = Calendar.current.component(.weekday, from: self) - 1
               return formatter.weekdaySymbols[weekdayIndex]
           }
           return formatter.string(from: self)
       }
       
       func daysBetween(date: Date) -> Int {
           let calendar = Calendar.current
           let date1 = calendar.startOfDay(for: self)
           let date2 = calendar.startOfDay(for: date)
           
           if let daysBetween = calendar.dateComponents([.day], from: date1 , to: date2).day {
               return daysBetween
           }
           return 0
       }
       
       func formatDatum(_ date: Date) -> String {
           return Date.shortDateFormatter.string(from: date)
       }

       func formatUhrzeit(_ date: Date) -> String {
           return Date.timeFormatter.string(from: date)
       }
       
       func convertToDate(from dateString: String) -> Date? {
           return Date.combinedFormatter.date(from: dateString)
       }
    
    
        static var databaseDateFormatter: DateFormatter {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                return formatter
            }
    
    
}
