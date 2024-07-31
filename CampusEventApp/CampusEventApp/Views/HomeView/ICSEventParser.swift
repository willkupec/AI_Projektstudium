import Foundation
import EventKit

class ICSEventParser {
    static func parseICS(content: String) -> [ICSEvent] {
        var events = [ICSEvent]()
        let lines = content.split(separator: "\n")
        
        var summary = ""
        var startDate: Date?
        var endDate: Date?
        var location = ""
        var recurrenceRule: EKRecurrenceRule?
        
        // Adjust date format to match .ics file format
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd'T'HHmmss"
        dateFormatter.timeZone = TimeZone(identifier: "Europe/Berlin")
        
        for line in lines {
            if line.hasPrefix("SUMMARY:") {
                summary = String(line.dropFirst(8))
            } else if line.hasPrefix("DTSTART;TZID=Europe/Berlin:") {
                let dateString = String(line.dropFirst(27)).trimmingCharacters(in: .whitespacesAndNewlines)
                startDate = dateFormatter.date(from: dateString)
                if startDate == nil {
                    print("Failed to parse DTSTART date: \(dateString)")
                }
            } else if line.hasPrefix("DTEND;TZID=Europe/Berlin:") {
                let dateString = String(line.dropFirst(25)).trimmingCharacters(in: .whitespacesAndNewlines)
                endDate = dateFormatter.date(from: dateString)
                if endDate == nil {
                    print("Failed to parse DTEND date: \(dateString)")
                }
            } else if line.hasPrefix("LOCATION:") {
                location = String(line.dropFirst(9))
            } else if line.hasPrefix("RRULE:") {
                recurrenceRule = parseRecurrenceRule(line: String(line.dropFirst(6)))
            } else if line.hasPrefix("END:VEVENT") {
                if let startDate = startDate, let endDate = endDate {
                    let event = ICSEvent(summary: summary, startDate: startDate, endDate: endDate, location: location, recurrenceRule: recurrenceRule)
                    events.append(event)
                } else {
                    print("Missing start or end date for event.")
                }
                // Reset for the next event
                summary = ""
                startDate = nil
                endDate = nil
                location = ""
                recurrenceRule = nil
            }
        }
        return events
    }

    static func parseRecurrenceRule(line: String) -> EKRecurrenceRule? {
        let components = line.split(separator: ";")
        var frequency: EKRecurrenceFrequency?
        var interval: Int = 1
        var daysOfTheWeek: [EKRecurrenceDayOfWeek] = []
        var endDate: Date?

        for component in components {
            let pair = component.split(separator: "=")
            if pair.count == 2 {
                let key = pair[0]
                let value = pair[1]

                switch key {
                case "FREQ":
                    frequency = parseFrequency(value: String(value))
                case "INTERVAL":
                    interval = Int(value) ?? 1
                case "BYDAY":
                    daysOfTheWeek = parseByDay(value: String(value))
                case "UNTIL":
                    endDate = parseUntilDate(value: String(value))
                default:
                    break
                }
            }
        }

        guard let freq = frequency else { return nil }
        return EKRecurrenceRule(
            recurrenceWith: freq,
            interval: interval,
            daysOfTheWeek: daysOfTheWeek.isEmpty ? nil : daysOfTheWeek,
            daysOfTheMonth: nil,
            monthsOfTheYear: nil,
            weeksOfTheYear: nil,
            daysOfTheYear: nil,
            setPositions: nil,
            end: endDate != nil ? EKRecurrenceEnd(end: endDate!) : nil
        )
    }

    static func parseFrequency(value: String) -> EKRecurrenceFrequency? {
        switch value {
        case "DAILY":
            return .daily
        case "WEEKLY":
            return .weekly
        case "MONTHLY":
            return .monthly
        case "YEARLY":
            return .yearly
        default:
            return nil
        }
    }

    static func parseByDay(value: String) -> [EKRecurrenceDayOfWeek] {
        let days = value.split(separator: ",")
        var daysOfTheWeek: [EKRecurrenceDayOfWeek] = []
        for day in days {
            switch day {
            case "MO":
                daysOfTheWeek.append(EKRecurrenceDayOfWeek(.monday))
            case "TU":
                daysOfTheWeek.append(EKRecurrenceDayOfWeek(.tuesday))
            case "WE":
                daysOfTheWeek.append(EKRecurrenceDayOfWeek(.wednesday))
            case "TH":
                daysOfTheWeek.append(EKRecurrenceDayOfWeek(.thursday))
            case "FR":
                daysOfTheWeek.append(EKRecurrenceDayOfWeek(.friday))
            case "SA":
                daysOfTheWeek.append(EKRecurrenceDayOfWeek(.saturday))
            case "SU":
                daysOfTheWeek.append(EKRecurrenceDayOfWeek(.sunday))
            default:
                break
            }
        }
        return daysOfTheWeek
    }

    static func parseUntilDate(value: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd'T'HHmmss'Z'"
        return dateFormatter.date(from: value)
    }
}
