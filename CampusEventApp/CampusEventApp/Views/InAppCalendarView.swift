import SwiftUI
import EventKit

struct InAppCalendarView: View {
    @Binding var events: [EKEvent]
    
    @State private var currentDate = Date()
    @State private var selectedDate: Date? = nil
    @State private var showEventDetails = false
    private let calendar = Calendar.current
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    currentDate = calendar.date(byAdding: .month, value: -1, to: currentDate) ?? currentDate
                }) {
                    Image(systemName: "chevron.left")
                        .padding()
                }
                Spacer()
                Text(dateFormatter.string(from: currentDate))
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                Spacer()
                Button(action: {
                    currentDate = calendar.date(byAdding: .month, value: 1, to: currentDate) ?? currentDate
                }) {
                    Image(systemName: "chevron.right")
                        .padding()
                }
            }
            
            let days = generateDaysInMonth(for: currentDate)
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
                ForEach(days, id: \.self) { day in
                    DayView(day: day, events: eventsForDate(date: day.date))
                        .onTapGesture {
                            selectedDate = day.date
                            showEventDetails = true
                        }
                        .frame(width: 50, height: 50)
                }
            }
            Spacer()
        }
        .padding()
        .sheet(isPresented: $showEventDetails) {
            if let selectedDate = selectedDate {
                EventDetailsView(date: selectedDate, events: eventsForDate(date: selectedDate))
            }
        }
        .navigationTitle("Calendar")
    }
    
    private func generateDaysInMonth(for date: Date) -> [Day] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: date) else {
            return []
        }

        let monthStart = monthInterval.start
        let monthEnd = monthInterval.end

        var days: [Day] = []
        var date = monthStart
        while date < monthEnd {
            let day = calendar.component(.day, from: date)
            days.append(Day(date: date, day: day))
            date = calendar.date(byAdding: .day, value: 1, to: date) ?? date
        }
        
        return days
    }
    
    private func eventsForDate(date: Date) -> [EKEvent] {
        let localDate = calendar.startOfDay(for: date)
        return events.filter {
            calendar.isDate($0.startDate, inSameDayAs: localDate)
        }
    }
}

struct Day: Hashable {
    let date: Date
    let day: Int
}

struct DayView: View {
    let day: Day
    let events: [EKEvent]
    
    var body: some View {
        ZStack {
            Circle()
                .fill(events.isEmpty ? Color.clear : Color.blue.opacity(0.3))
                .frame(width: 40, height: 40)
            Text("\(day.day)")
                .font(.headline)
                .foregroundColor(events.isEmpty ? .primary : .white)
        }
    }
}

struct EventDetailsView: View {
    let date: Date
    let events: [EKEvent]

    var body: some View {
        VStack {
            Text("Events on \(formattedDate(date))")
                .font(.headline)
                .padding()
            List(events, id: \.eventIdentifier) { event in
                VStack(alignment: .leading) {
                    Text(event.title ?? "No Title")
                        .font(.headline)
                    Text(event.startDate, style: .date)
                    Text(event.startDate, style: .time)
                    Text(event.notes ?? "")
                }
                .padding()
            }
            .listStyle(PlainListStyle())
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter.string(from: date)
    }
}
