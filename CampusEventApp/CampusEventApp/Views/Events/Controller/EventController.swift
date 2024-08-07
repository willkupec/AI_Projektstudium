import Foundation

class EventController {
    let MONGO_URL = "http://canwrobel.de:8090/events"
    var shouldReloadEvents: Bool = true
    var shouldReloadEventDetail: Bool = true
    
    func fetchEvents(completion: @escaping ([Event]) -> Void) {
        guard let url = URL(string: MONGO_URL) else {
            print("Invalid URL")
            return
        }

        performRequest(url: url, method: "GET") { data, error in
            self.handleEventResponse(data: data, error: error, completion: completion)
        }
    }

    func fetchEventDetails(eventID: String, completion: @escaping (Event?) -> Void) {
        guard let url = URL(string: "\(MONGO_URL)/\(eventID)") else {
            print("Invalid URL")
            return
        }

        performRequest(url: url, method: "GET") { data, error in
            self.handleSingleEventResponse(data: data, error: error, completion: completion)
        }
    }

    func createEvent(event: Event) {
        guard let url = URL(string: MONGO_URL) else {
            print("Invalid URL")
            return
        }

        guard let jsonData = try? JSONSerialization.data(withJSONObject: self.eventToDictionary(event: event)) else {
            print("Error serializing JSON")
            return
        }

        performRequest(url: url, method: "POST", body: jsonData) { data, error in
            self.handleSimpleResponse(data: data, error: error)
        }
    }

    func updateEvent(event: Event) {
        guard let url = URL(string: "\(MONGO_URL)/\(event.id)") else {
            print("Invalid URL")
            return
        }

        guard let jsonData = try? JSONSerialization.data(withJSONObject: self.eventToDictionary(event: event)) else {
            print("Error serializing JSON")
            return
        }

        performRequest(url: url, method: "PUT", body: jsonData) { data, error in
            self.handleSimpleResponse(data: data, error: error)
        }
    }

    func deleteEvent(eventID: String) {
        guard let url = URL(string: "\(MONGO_URL)/\(eventID)") else {
            print("Invalid URL")
            return
        }

        performRequest(url: url, method: "DELETE") { data, error in
            self.handleSimpleResponse(data: data, error: error)
        }
    }

    func createPost(to event: Event, post: Post) {
        guard let url = URL(string: "\(MONGO_URL)/\(event.id)/posts") else {
            print("Invalid URL")
            return
        }

        guard let jsonData = try? JSONSerialization.data(withJSONObject: self.postToDictionary(post: post)) else {
            print("Error serializing JSON")
            return
        }

        performRequest(url: url, method: "POST", body: jsonData) { data, error in
            self.handleSimpleResponse(data: data, error: error)
        }
    }

    func fetchEventPosts(eventID: String, completion: @escaping ([Post]) -> Void) {
        guard let url = URL(string: "\(MONGO_URL)/\(eventID)/posts") else {
            print("Invalid URL")
            return
        }

        performRequest(url: url, method: "GET") { data, error in
            self.handlePostResponse(data: data, error: error, completion: completion)
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
            completion(error == nil)
        }
    }

    func deletePost(eventID: String, postID: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(MONGO_URL)/\(eventID)/posts/\(postID)") else {
            print("Invalid URL")
            return
        }

        performRequest(url: url, method: "DELETE") { data, error in
            completion(error == nil)
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

    private func eventToDictionary(event: Event) -> [String: Any] {
        return [
            "veranstalterId": event.organizerId,
            "veranstalterName": event.organizerName,
            "titel": event.name,
            "beschreibung": event.description,
            "tag": Date.databaseDateFormatter.string(from: event.date),
            "start": event.start,
            "ende": event.end,
            "typ": event.type,
            "foto": event.photo,
            "ort": event.location
        ]
    }

    private func postToDictionary(post: Post) -> [String: Any] {
        return [
            "authorId": post.authorId,
            "authorName": post.authorName,
            "title": post.title,
            "content": post.content,
            "createdAt": Date.databaseDateFormatter.string(from: post.time)
        ]
    }


    private func handleEventResponse(data: Data?, error: Error?, completion: @escaping ([Event]) -> Void) {
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
                          let date = Date.databaseDateFormatter.date(from: dateString) else {
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

    private func handleSingleEventResponse(data: Data?, error: Error?, completion: @escaping (Event?) -> Void) {
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
                      let date = Date.databaseDateFormatter.date(from: dateString) else {
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

    private func handlePostResponse(data: Data?, error: Error?, completion: @escaping ([Post]) -> Void) {
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
                          let date = Date.databaseDateFormatter.date(from: dateString) else {
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

    private func handleSimpleResponse(data: Data?, error: Error?) {
        guard let data = data, error == nil else {
            print("Error handling request: \(error?.localizedDescription ?? "Unknown error")")
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
