//
//  AppState.swift
//  ChatApp
//
//  Created by Michal Ukropec on 16/04/2025.
//

import Foundation
import SwiftUI

struct Message: Codable {
    var text: String
    var date: Date
    var isOwn: Bool
}

struct Thread: Codable, Identifiable {
    var id = UUID()
    var name: String
    var messages: [Message]
    var lastMessageDate: Date
    var createdAt: Date
}

class AppState: ObservableObject {
    @Published var searchBarFocus: Bool = false
    @Published var searchBarText: String = ""

    @Published var messageBarFocus: Bool = false
    @Published var messageBarText: String = ""

    @Published var currentAIModel: String = "gpt-3.5-turbo"

    @Published var currentThread: String {
        didSet {
            UserDefaults.standard.set(currentThread, forKey: "currentThread")
        }
    }

    @Published var threads: [Thread] {
        didSet {
            saveThreads()
        }
    }

    init() {
        self.currentThread =
            UserDefaults.standard.string(forKey: "currentThread") ?? ""
        self.threads = AppState.loadThreads()
    }

    private func saveThreads() {
        if let data = try? JSONEncoder().encode(threads) {
            UserDefaults.standard.set(data, forKey: "threads")
        }
    }

    private static func loadThreads() -> [Thread] {
        if let data = UserDefaults.standard.data(forKey: "threads"),
            let threads = try? JSONDecoder().decode([Thread].self, from: data)
        {
            return threads
        }
        return []
    }

    func deleteCurrentThread() {
        threads.removeAll { $0.id.uuidString == currentThread }
        currentThread = ""
    }

    var filteredThreads: [Thread] {
        let trimmedQuery = searchBarText.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).lowercased()

        if trimmedQuery.isEmpty {
            return threads.sorted { $0.createdAt > $1.createdAt }
        } else {
            return
                threads
                .filter { $0.name.lowercased().contains(trimmedQuery) }
                .sorted { $0.name.lowercased() < $1.name.lowercased() }
        }
    }

    var currentThreadObject: Thread? {
        threads.first { $0.id.uuidString == currentThread }
    }

    var currentMessages: [Message] {
        currentThreadObject?.messages ?? []
    }

    func addMessage(_ text: String, isOwn: Bool) {
        guard
            let index = threads.firstIndex(where: {
                $0.id.uuidString == currentThread
            })
        else { return }

        let message = Message(text: text, date: Date(), isOwn: isOwn)
        threads[index].messages.append(message)
        threads[index].lastMessageDate = message.date
    }

    func deleteMessage(at index: Int) {
        guard
            let threadIndex = threads.firstIndex(where: {
                $0.id.uuidString == currentThread
            })
        else { return }
        guard threads[threadIndex].messages.indices.contains(index) else {
            return
        }

        threads[threadIndex].messages.remove(at: index)
    }

    func formattedMessagesForOpenAI() -> [[String: String]] {
        currentMessages.map { message in
            [
                "role": message.isOwn ? "user" : "system",
                "content": message.text,
            ]
        }
    }

    func sendToOpenAI(apiKey: String, completion: @escaping (String?) -> Void) {
        let messages = formattedMessagesForOpenAI()
        guard
            let url = URL(string: "https://api.openai.com/v1/chat/completions")
        else {
            completion(nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue(
            "Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "model": currentAIModel,
            "messages": messages,
            "temperature": 0.7,
        ]

        do {
            request.httpBody = try JSONSerialization.data(
                withJSONObject: body, options: [])
        } catch {
            print("Failed to encode body:", error)
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("OpenAI error:", error)
                completion(nil)
                return
            }

            guard
                let data = data,
                let json = try? JSONSerialization.jsonObject(with: data)
                    as? [String: Any],
                let choices = json["choices"] as? [[String: Any]],
                let message = choices.first?["message"] as? [String: Any],
                let content = message["content"] as? String
            else {
                print("Unexpected response from OpenAI.")
                completion(nil)
                return
            }

            completion(content)
        }.resume()
    }

}
