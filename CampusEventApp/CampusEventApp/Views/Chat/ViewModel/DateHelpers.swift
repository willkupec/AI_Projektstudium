//
//  DateHelpers.swift
//  CampusEventApp
//
//  Created on 25.05.24.
//

import Foundation

extension Date {
    
    func descriptiveString(dateStyle: DateFormatter.Style = .short) -> String {
        
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        
        let daysBetween = self.daysBetween(date: Date())
        
        if daysBetween == 0 {
            return "Today"
        }
        else if daysBetween == 1 {
            return "Yesterday"
        }
        else if daysBetween < 5 {
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
    
    
    
    
    
    
    // Funktion die Date() im Format "Tag.Monat.Jahr" zurückgibt
    func formatDatum(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"   //Format "13.7.2016" als Beispiel
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }

    // Funktion die Date() im Format "Stunde:Minute Uhr" zurückgibt
    func formatUhrzeit(_ date: Date) -> String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "H:mm 'Uhr'" // Format "9:00 Uhr" als Beispiel
        let formattedTime = timeFormatter.string(from: date)
        return formattedTime
    }
    
    // Funktion die einen String im Format "Tag.Monat.Jahr:Stunde,Minute Uhr" in ein Date konvertiert
    func convertToDate(from dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy,H:mm 'Uhr'" //Beispielformat: "13.6.2016,9:00 Uhr"
        return dateFormatter.date(from: dateString)
    }
    
    
}
