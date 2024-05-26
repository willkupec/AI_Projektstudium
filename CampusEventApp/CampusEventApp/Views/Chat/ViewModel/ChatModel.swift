//
//  ChatModel.swift
//  CampusEventApp
//
//  Created on 21.05.24.
//

import Foundation

struct Chat: Identifiable {
    var id: UUID { person.id }
    let person: Person
    var messages: [Message]
    var hasUnreadMessage = false
}

struct Person: Identifiable {
    let id = UUID()
    let name: String
    let imgString: String
}

struct Message: Identifiable {
    
    enum MessageType {
        case Sent, Received
    }
    
    let id = UUID()
    let date: Date
    let text: String
    let type: MessageType
    
    init(_ text: String, type: MessageType, date:Date) {
        self.date = date
        self.type = type
        self.text = text
    }
    
    init(_ text: String, type: MessageType) {
        self.init(text, type: type, date: Date())
    }
}

extension Chat {
    
    
    static let sampleChat = [
    Chat(person: Person(name: "Person1", imgString: "person"), messages: [
        Message("Hey", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 3)),
        Message("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 3)),
        Message("erat, sed diam voluptua", type: .Sent, date: Date (timeIntervalSinceNow: -86400 * 3)),
        Message("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam", type: .Received, date: Date (timeIntervalSinceNow: -86400 * 2)),
        Message("Lorem ipsum amet, consetetur elitr, sed diam 😄", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 2)),
        Message("invidunt ut labore et dolore magna aliquyam", type: .Received, date: Date (timeIntervalSinceNow: -86400 * 2)),
        Message("consetetur elitr dolore magna aliquyam", type: .Received, date: Date (timeIntervalSinceNow: -86400 * 1)),
        Message("Hmm", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 1)),
        Message("Okay", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 1)),
        Message("sanctus elitr dolore magna", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 1)),
        Message("sea takimata sanctus est Lorem", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 1)),
        Message("At vero eos et accusam et justo duo dolores et ea rebum", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 1)),
        Message("At vero eos et accusam consetetur sadipscing et justo diam voluptua duo dolores et ea consetetur elitr rebum", type: .Received, date: Date()),
        ], hasUnreadMessage: true),
    
    Chat(person: Person(name: "Person2", imgString: "person"), messages: [
        Message("Hey Person2", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 30)),
        Message("Ich mache gerade eine CampusApp, kannst du mir helfen?", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 30)),
        Message("Bitte ich brauch wirklich deine Hilfe! ", type: .Sent, date: Date (timeIntervalSinceNow: -86400 * 30)),
        Message("Klar, was soll icht´tun?", type: .Received, date: Date (timeIntervalSinceNow: -86400 * 17)),
        Message("Keine Ahnung, hast du Erfahrung mit IOS Apps?", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 17)),
        Message("Ne nur mit Android", type: .Received, date: Date (timeIntervalSinceNow: -86400 * 17)),
        Message("Aber hast du mal ChatGPT gefragt?", type: .Received, date: Date (timeIntervalSinceNow: -86400 * 17)),
        Message("Ne das bringt doch nix", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 7)),
        Message("na wenn du meinst", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 7)),
        Message("Ja also kannst du mir nicht helfen?", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 7)),
        Message("Denke nicht", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 7)),
        Message("Na gut dann frag ich wenn anderes", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 1)),
        Message("Okay alles klar", type: .Received, date: Date()),
        ], hasUnreadMessage: true),
    
    Chat(person: Person(name: "Person3", imgString: "person"), messages: [
        Message("Hey", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 3)),
        Message("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 3)),
        Message("erat, sed diam voluptua", type: .Sent, date: Date (timeIntervalSinceNow: -86400 * 3)),
        Message("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam", type: .Received, date: Date (timeIntervalSinceNow: -86400 * 3)),
        Message("Lorem ipsum amet, consetetur elitr, sed diam 😄", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 3)),
        Message("invidunt ut labore et dolore magna aliquyam", type: .Received, date: Date (timeIntervalSinceNow: -86400 * 3)),
        Message("consetetur elitr dolore magna aliquyam", type: .Received, date: Date (timeIntervalSinceNow: -86400 * 3)),
        Message("Hmm", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 3)),
        Message("Okay", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 3)),
        Message("sanctus elitr dolore magna", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 3)),
        Message("sea takimata sanctus est Lorem", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 3)),
        Message("At vero eos et accusam et justo duo dolores et ea rebum", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 3)),
        Message("At vero eos et accusam consetetur sadipscing et justo diam voluptua duo dolores et ea consetetur elitr rebum", type: .Received, date: Date()),
        ], hasUnreadMessage: false),
    
    Chat(person: Person(name: "Unknown", imgString: "person"), messages: [
        Message("Hey ???", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 3)),
        Message("?????????????????????????????????????????????????????????????????????????????????????????????????????????????????", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 3)),
        Message("??????????????????????", type: .Sent, date: Date (timeIntervalSinceNow: -86400 * 3)),
        Message("?????????????????????", type: .Received, date: Date (timeIntervalSinceNow: -86400 * 2)),
        Message("???????????????????????????????????????????", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 2)),
        Message("????????????????????????????", type: .Received, date: Date (timeIntervalSinceNow: -86400 * 2)),
        Message("???????????????????????????????", type: .Received, date: Date (timeIntervalSinceNow: -86400 * 1)),
        Message("???????", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 1)),
        Message("????", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 1)),
        Message("????????", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 1)),
        Message("???????????????", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 1)),
        Message("????????????????????????????????????????????????????????????????????????????????", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 1)),
        Message("???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 10)),
        ], hasUnreadMessage: true),
    
    Chat(person: Person(name: "Person4", imgString: "person"), messages: [
        Message("Hey", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 3)),
        Message("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 3)),
        Message("erat, sed diam voluptua", type: .Sent, date: Date (timeIntervalSinceNow: -86400 * 3)),
        Message("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam", type: .Received, date: Date (timeIntervalSinceNow: -86400 * 2)),
        Message("Lorem ipsum amet, consetetur elitr, sed diam 😄", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 2)),
        Message("invidunt ut labore et dolore magna aliquyam", type: .Received, date: Date (timeIntervalSinceNow: -86400 * 2)),
        Message("consetetur elitr dolore magna aliquyam", type: .Received, date: Date (timeIntervalSinceNow: -86400 * 1)),
        Message("Hmm", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 1)),
        Message("Okay", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 1)),
        Message("sanctus elitr dolore magna", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 1)),
        Message("sea takimata sanctus est Lorem", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 1)),
        Message("At vero eos et accusam et justo duo dolores et ea rebum", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 1)),
        Message("At vero eos et accusam consetetur sadipscing et justo diam voluptua duo dolores et ea consetetur elitr rebum", type: .Received, date: Date()),
        ], hasUnreadMessage: false),
    
    Chat(person: Person(name: "Person5", imgString: "person"), messages: [
        Message("Hey", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 13)),
        Message("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 13)),
        Message("erat, sed diam voluptua", type: .Sent, date: Date (timeIntervalSinceNow: -86400 * 13)),
        Message("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam", type: .Received, date: Date (timeIntervalSinceNow: -86400 * 13)),
        Message("Lorem ipsum amet, consetetur elitr, sed diam 😄", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 10)),
        Message("invidunt ut labore et dolore magna aliquyam", type: .Received, date: Date (timeIntervalSinceNow: -86400 * 9)),
        Message("consetetur elitr dolore magna aliquyam", type: .Received, date: Date (timeIntervalSinceNow: -86400 * 9)),
        Message("Hmm", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 9)),
        Message("Okay", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 9)),
        Message("sanctus elitr dolore magna", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 7)),
        Message("sea takimata sanctus est Lorem", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 7)),
        Message("At vero eos et accusam et justo duo dolores et ea rebum", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 7)),
        Message("At vero eos et accusam consetetur sadipscing et justo diam voluptua duo dolores et ea consetetur elitr rebum", type: .Received, date: Date()),
        ], hasUnreadMessage: false),
    
    Chat(person: Person(name: "Person6", imgString: "person"), messages: [
        Message("Hey", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 3)),
        Message("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 3)),
        Message("erat, sed diam voluptua", type: .Sent, date: Date (timeIntervalSinceNow: -86400 * 3)),
        Message("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam", type: .Received, date: Date (timeIntervalSinceNow: -86400 * 2)),
        Message("Lorem ipsum amet, consetetur elitr, sed diam 😄", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 2)),
        Message("invidunt ut labore et dolore magna aliquyam", type: .Received, date: Date (timeIntervalSinceNow: -86400 * 2)),
        Message("consetetur elitr dolore magna aliquyam", type: .Received, date: Date (timeIntervalSinceNow: -86400 * 1)),
        Message("Hmm", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 1)),
        Message("Okay", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 1)),
        Message("sanctus elitr dolore magna", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 1)),
        Message("sea takimata sanctus est Lorem", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 1)),
        Message("At vero eos et accusam et justo duo dolores et ea rebum", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 1)),
        Message("At vero eos et accusam consetetur sadipscing et justo diam voluptua duo dolores et ea consetetur elitr rebum", type: .Received, date: Date()),
        ], hasUnreadMessage: true),
    
    Chat(person: Person(name: "Person7", imgString: "person"), messages: [
        Message("Hey", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 30)),
        Message("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 30)),
        Message("erat, sed diam voluptua", type: .Sent, date: Date (timeIntervalSinceNow: -86400 * 30)),
        Message("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam", type: .Received, date: Date (timeIntervalSinceNow: -86400 * 20)),
        Message("Lorem ipsum amet, consetetur elitr, sed diam 😄", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 17)),
        Message("invidunt ut labore et dolore magna aliquyam", type: .Received, date: Date (timeIntervalSinceNow: -86400 * 17)),
        Message("consetetur elitr dolore magna aliquyam", type: .Received, date: Date (timeIntervalSinceNow: -86400 * 16)),
        Message("Hmm", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 15)),
        Message("Okay", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 15)),
        Message("sanctus elitr dolore magna", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 15)),
        Message("sea takimata sanctus est Lorem", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 15)),
        Message("At vero eos et accusam et justo duo dolores et ea rebum", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 15)),
        Message("At vero eos et accusam consetetur sadipscing et justo diam voluptua duo dolores et ea consetetur elitr rebum", type: .Received, date: Date()),
        ], hasUnreadMessage: false),
    
    
    
    ]
}
