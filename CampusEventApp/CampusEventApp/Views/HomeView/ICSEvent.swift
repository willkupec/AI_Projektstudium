import Foundation
import EventKit

struct ICSEvent {
    var summary: String
    var startDate: Date
    var endDate: Date
    var location: String
    var recurrenceRule: EKRecurrenceRule?
}
