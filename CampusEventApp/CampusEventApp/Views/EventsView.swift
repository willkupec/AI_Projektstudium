//
//  EventsView.swift
//  CampusEventApp
//
//  Created by Reinardus on 18.05.24.
//
import SwiftUI

struct Event: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let time: String
    let date: String
}

struct EventsView: View {
    let events = [
        Event(name: "B11.1 Programmierung 1", time: "8:51 Uhr", date: "17.3.2024"),
        Event(name: "B23.2 Mobile Betriebssysteme", time: "9:00 Uhr", date: "18.3.2024"),
        Event(name: "B51 Projektstudium", time: "10:15 Uhr", date: "19.3.2024"),
        Event(name: "B1.2 Mathe 1", time: "11:30 Uhr", date: "20.3.2024")
    ]
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            List {
                ForEach(searchResults) { event in
                    HStack {
                        VStack {
                            HStack {
                                Text(event.name)
                                    .font(.system(size: 18))
                                    .fontWeight(.bold)
                                    .padding(.bottom, 3)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            HStack {
                                Text(event.time)
                                    .padding(.trailing, 30)
                                
                                Text(event.date)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                        }.frame(alignment: .leading)
                        
                        Image(systemName: "message.fill")
                            .foregroundColor(Color.black)
                            .frame(width: 50, height: 50)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .navigationTitle("Events")
        }
        .searchable(text: $searchText)
    }

    var searchResults: [Event] {
        if searchText.isEmpty {
            return events
        } else {
            return events.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EventsView()
    }
}
