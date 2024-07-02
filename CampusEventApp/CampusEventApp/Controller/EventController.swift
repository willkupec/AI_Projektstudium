import Foundation

class EventController {
    let MONGO_URL = "http://localhost:80/events"
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
                              let organizerId = dict["veranstalterId"] as? String,
                              let organizerName = dict["veranstalterName"] as? String,
                              let location = dict["ort"] as? String,
                              let photo = dict["foto"] as? String,
                              let dateString = dict["tag"] as? String,
                              let date = self.dateFormatter.date(from: dateString) else {
                            return nil
                        }
                        return Event(id: id, name: name, start: start, end: end, date: date, type: type, description: description, organizerId: organizerId, organizerName: organizerName, location: location, photo: photo, posts: [])
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
                          let organizerId = json["veranstalterId"] as? String,
                          let organizerName = json["veranstalterName"] as? String,
                          let location = json["ort"] as? String,
                          let photo = json["foto"] as? String,
                          let dateString = json["tag"] as? String,
                          let date = self.dateFormatter.date(from: dateString) else {
                        return completion(nil)
                    }
                    let event = Event(id: id, name: name, start: start, end: end, date: date, type: type, description: description, organizerId: organizerId, organizerName: organizerName, location: location, photo: photo, posts: [])
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
            "veranstalterId": event.organizerId,
            "veranstalterName": event.organizerName,
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
            "veranstalterId": event.organizerId,
            "veranstalterName": event.organizerName,
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

    func createPost(to event: Event, post: Post) {
        guard let url = URL(string: "\(MONGO_URL)/\(event.id)/posts") else {
            print("Invalid URL")
            return
        }

        let json: [String: Any] = [
            "authorId": post.authorId,
            "authorName": post.authorName,
            "title": post.title,
            "content": post.content,
            "createdAt": dateFormatter.string(from: post.time)
        ]

        guard let jsonData = try? JSONSerialization.data(withJSONObject: json) else {
            print("Error serializing JSON")
            return
        }

        performRequest(url: url, method: "POST", body: jsonData) { data, error in
            guard let data = data, error == nil else {
                print("Error creating post: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            if let rawResponse = String(data: data, encoding: .utf8) {
                print("Raw response: \(rawResponse)")
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

    func fetchEventPosts(eventID: String, completion: @escaping ([Post]) -> Void) {
        guard let url = URL(string: "\(MONGO_URL)/\(eventID)/posts") else {
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
                              let eventId = dict["eventId"] as? String,
                              let authorId = dict["authorId"] as? String,
                              let authorName = dict["authorName"] as? String,
                              let title = dict["title"] as? String,
                              let content = dict["content"] as? String,
                              let dateString = dict["createdAt"] as? String,
                              let isOnceEdited = dict["isOnceEdited"] as? Bool,
                              let date = self.dateFormatter.date(from: dateString) else {
                            return nil
                        }
                        return Post(id: id, eventId: eventId, authorId: authorId, authorName: authorName, title: title, content: content, time: date, isOnceEdited: isOnceEdited)
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

    func updatePost(eventID: String, postID: String, updatedContent: [String: Any], completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(MONGO_URL)/\(eventID)/posts/\(postID)") else {
            print("Invalid URL")
            return
        }

        guard let jsonData = try? JSONSerialization.data(withJSONObject: updatedContent) else {
            print("Error serializing JSON")
            completion(false)
            return
        }

        performRequest(url: url, method: "PUT", body: jsonData) { data, error in
            guard error == nil else {
                print("Error updating post: \(error?.localizedDescription ?? "Unknown error")")
                completion(false)
                return
            }
            completion(true)
        }
    }

    func deletePost(eventID: String, postID: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(MONGO_URL)/\(eventID)/posts/\(postID)") else {
            print("Invalid URL")
            return
        }

        performRequest(url: url, method: "DELETE") { data, error in
            guard error == nil else {
                print("Error deleting post: \(error?.localizedDescription ?? "Unknown error")")
                completion(false)
                return
            }
            completion(true)
        }
    }

    private func performRequest(url: URL, method: String, body: Data? = nil, completion: @escaping (Data?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response as? HTTPURLResponse {
                print("HTTP Status Code: \(response.statusCode)")
                print("Response Headers: \(response.allHeaderFields)")
            }

            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print("Response Data: \(json)")
                } catch {
                    print("Error parsing JSON: \(error.localizedDescription)")
                    if let rawResponse = String(data: data, encoding: .utf8) {
                        print("Raw Response Data: \(rawResponse)")
                    }
                }
            }

            completion(data, error)
        }

        task.resume()
    }
}
