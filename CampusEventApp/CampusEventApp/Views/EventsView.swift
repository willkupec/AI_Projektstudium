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
    @State private var showingQRCode = false
    @State private var selectedEvent: Event?
    @State private var showingScanner = false

    var body: some View {
        NavigationStack {
            VStack {
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
                            
                            Button(action: {
                                selectedEvent = event
                                showingQRCode = true
                            }) {
                                Image(systemName: "qrcode")
                                    .foregroundColor(Color.black)
                                    .frame(width: 50, height: 50)
                            }
                            .sheet(isPresented: $showingQRCode) {
                                if let selectedEvent = selectedEvent {
                                    QRCodeView(event: selectedEvent)
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .listRowSeparator(.hidden)
                    }
                }
                .listStyle(.plain)
                .frame(alignment: .center)
                .navigationTitle("Events")
                .navigationBarItems(trailing: Button(action: {
                    showingScanner = true
                }) {
                    Image(systemName: "qrcode.viewfinder")
                        .imageScale(.large)
                })
            }
            .searchable(text: $searchText)
            .sheet(isPresented: $showingScanner) {
                QRCodeScannerParentView()
            }
        }
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
