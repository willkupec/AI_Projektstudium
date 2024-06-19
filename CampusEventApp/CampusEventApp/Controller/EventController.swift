import Foundation
import UIKit

class EventController {
    
    //let MONGO_URL = http://localhost/events
    let MONGO_URL = "http://malina.f4.htw-berlin.de/events"
    var shouldReloadEvents: Bool = true
    var shouldReloadEventDetail: Bool = true
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter
    }()
    
    func fetchEvents(completion: @escaping ([Event]) -> Void) {
        guard let url = URL(string: MONGO_URL) else {
            print("Invalid URL")
            return
        }

        performRequest(url: url, method: "GET") { data, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    let events = json.compactMap { dict -> Event? in
                        guard let id = dict["_id"] as? String,
                              let name = dict["titel"] as? String,
                              let start = dict["start"] as? String,
                              let end = dict["ende"] as? String,
                              let type = dict["typ"] as? String,
                              let description = dict["beschreibung"] as? String,
                              let organizer = dict["veranstalter"] as? String,
                              let location = dict["ort"] as? String,
                              let photo = dict["foto"] as? String,
                              let dateString = dict["tag"] as? String,
                              let date = self.dateFormatter.date(from: dateString) else {
                            return nil
                        }
                        return Event(id: id, name: name, start: start, end: end, date: date, type: type, description: description, organizer: organizer, location: location, photo: photo, posts: [])
                    }
                    DispatchQueue.main.async {
                        completion(events)
                    }
                }
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }
    }
    
    func fetchEventPosts(eventID: String, completion: @escaping ([Post]) -> Void) {
        guard let url = URL(string: "\(MONGO_URL)/\(eventID)/comments") else {
            print("Invalid URL")
            return
        }

        performRequest(url: url, method: "GET") { data, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    let posts = json.compactMap { dict -> Post? in
                        guard let id = dict["_id"] as? String,
                              let eventId = dict["eventID"] as? String,
                              let author = dict["posterUsername"] as? String,
                              let content = dict["text"] as? String,
                              let dateString = dict["createdAt"] as? String,
                              let date = self.dateFormatter.date(from: dateString) else {
                            return nil
                        }
                        
                        
                        return Post(id: id, eventId: eventId, author: author, title: "", content: content, time: date)
                    }
                    DispatchQueue.main.async {
                        completion(posts)
                    }
                }
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }
    }
    
    func fetchEventDetails(eventID: String, completion: @escaping (Event?) -> Void) {
        guard let url = URL(string: "\(MONGO_URL)/\(eventID)") else {
            print("Invalid URL")
            return
        }

        performRequest(url: url, method: "GET") { data, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    guard let id = json["_id"] as? String,
                          let name = json["titel"] as? String,
                          let start = json["start"] as? String,
                          let end = json["ende"] as? String,
                          let type = json["typ"] as? String,
                          let description = json["beschreibung"] as? String,
                          let organizer = json["veranstalter"] as? String,
                          let location = json["ort"] as? String,
                          let photo = json["foto"] as? String,
                          let dateString = json["tag"] as? String,
                          let date = self.dateFormatter.date(from: dateString) else {
                        return completion(nil)
                    }
                    let event = Event(id: id, name: name, start: start, end: end, date: date, type: type, description: description, organizer: organizer, location: location, photo: photo, posts: [])
                    DispatchQueue.main.async {
                        completion(event)
                    }
                }
            } catch {
                print("Error parsing JSON: \(error)")
                completion(nil)
            }
        }
    }

    func createEvent(event: Event) {
        guard let url = URL(string: MONGO_URL) else {
            print("Invalid URL")
            return
        }

        let json: [String: Any] = [
            "veranstalter": event.organizer,
            "titel": event.name,
            "beschreibung": event.description,
            "tag": dateFormatter.string(from: event.date),
            "start": event.start,
            "ende": event.end,
            "typ": event.type,
            "foto": event.photo,
            "ort": event.location
        ]

        guard let jsonData = try? JSONSerialization.data(withJSONObject: json) else {
            print("Error serializing JSON")
            return
        }

        performRequest(url: url, method: "POST", body: jsonData) { data, error in
            guard let data = data, error == nil else {
                print("Error sending data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if let rawResponse = String(data: data, encoding: .utf8) {
                print("Raw response: \(rawResponse)")
            }

            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("JSON Response: \(jsonResponse)")
                }
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }
    }
    
    func updateEvent(event: Event) {
        guard let url = URL(string: "\(MONGO_URL)/\(event.id)") else {
            print("Invalid URL")
            return
        }

        let json: [String: Any] = [
            "veranstalter": event.organizer,
            "titel": event.name,
            "beschreibung": event.description,
            "tag": dateFormatter.string(from: event.date),
            "start": event.start,
            "ende": event.end,
            "typ": event.type,
            "foto": event.photo,
            "ort": event.location
        ]

        guard let jsonData = try? JSONSerialization.data(withJSONObject: json) else {
            print("Error serializing JSON")
            return
        }

        performRequest(url: url, method: "PUT", body: jsonData) { data, error in
            guard let data = data, error == nil else {
                print("Error updating data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("JSON Response: \(jsonResponse)")
                }
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }
    }
    
    func deleteEvent(eventID: String) {
        guard let url = URL(string: "\(MONGO_URL)/\(eventID)") else {
            print("Invalid URL")
            return
        }

        performRequest(url: url, method: "DELETE") { data, error in
            guard let data = data, error == nil else {
                print("Error deleting data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("JSON Response: \(jsonResponse)")
                }
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }
    }

    func addPost(to event: Event, post: Post) {
        guard let url = URL(string: "\(MONGO_URL)/\(event.id)/posts") else {
            print("Invalid URL")
            return
        }

        let json: [String: Any] = [
            "author": post.author,
            "title": post.title,
            "content": post.content,
            "time": dateFormatter.string(from: post.time)
        ]

        guard let jsonData = try? JSONSerialization.data(withJSONObject: json) else {
            print("Error serializing JSON")
            return
        }

        performRequest(url: url, method: "POST", body: jsonData) { data, error in
            guard let data = data, error == nil else {
                print("Error adding post: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("Post added: \(jsonResponse)")
                }
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }
    }
    /*
    func addComment(to post: Post, comment: PostComment) {
        guard let url = URL(string: "\(MONGO_URL)/\(post.event.id)/posts/\(post.id)/comments") else {
            print("Invalid URL")
            return
        }

        let json: [String: Any] = [
            "author": comment.author,
            "content": comment.content,
            "timestamp": dateFormatter.string(from: comment.timestamp)
        ]

        guard let jsonData = try? JSONSerialization.data(withJSONObject: json) else {
            print("Error serializing JSON")
            return
        }

        performRequest(url: url, method: "POST", body: jsonData) { data, error in
            guard let data = data, error == nil else {
                print("Error adding comment: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("Comment added: \(jsonResponse)")
                }
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }
    }*/
    
    func createEventWithPhoto(event: Event, photo: UIImage, completion: @escaping (Bool) -> Void) {
            guard let url = URL(string: MONGO_URL) else {
                print("Invalid URL")
                completion(false)
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let boundary = UUID().uuidString
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

            let eventJson: [String: Any] = [
                "veranstalter": event.organizer,
                "titel": event.name,
                "beschreibung": event.description,
                "tag": dateFormatter.string(from: event.date),
                "start": event.start,
                "ende": event.end,
                "typ": event.type,
                "ort": event.location
            ]

            let eventData = try! JSONSerialization.data(withJSONObject: eventJson, options: [])

            var body = Data()
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"json\"\r\n\r\n".data(using: .utf8)!)
            body.append(eventData)
            body.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)

            let imageData = photo.jpegData(compressionQuality: 0.8)!
            body.append("Content-Disposition: form-data; name=\"foto\"; filename=\"photo.jpg\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            body.append(imageData)
            body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

            request.httpBody = body

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print("Error sending data: \(error?.localizedDescription ?? "Unknown error")")
                    completion(false)
                    return
                }

                if let rawResponse = String(data: data, encoding: .utf8) {
                    print("Raw response: \(rawResponse)")
                }

                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        print("JSON Response: \(jsonResponse)")
                        completion(true)
                    }
                } catch {
                    print("Error parsing JSON: \(error)")
                    completion(false)
                }
            }

            task.resume()
        }
    
    private func performRequest(url: URL, method: String, body: Data? = nil, completion: @escaping (Data?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            completion(data, error)
        }

        task.resume()
    }
}
