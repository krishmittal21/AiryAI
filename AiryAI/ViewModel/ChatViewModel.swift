//
//  ChatViewModel.swift
//  AiryAI
//
//  Created by Krish Mittal on 22/03/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore

class ChatViewModel: ObservableObject {
  @Published private(set) var conversation = [ChatMessage]()
  @Published var session = UUID().uuidString
  
  func sendMessages(message: String, imageData: [Data]) {
    conversation.append(.init(role: .user, message: message, images: imageData))
    guard let uId = Auth.auth().currentUser?.uid else { return }
    
    triggerChatAPI(input: message, userId: uId) { text in
      DispatchQueue.main.async {
        self.conversation.append(.init(role: .model, message: text, images: nil))
        self.saveMessages()
      }
    }
  }
  
  func saveMessages() {
    DispatchQueue.global(qos: .background).async {
      let db = Firestore.firestore()
      guard let uId = Auth.auth().currentUser?.uid else { return }
      var messages = [[String: Any]]()
      for message in self.conversation {
        var messageData: [String: Any] = [
          "role": message.role == .user ? "user" : "model",
          "message": message.message
        ]
        if let images = message.images {
          var imageStrings = [String]()
          for image in images {
            let base64String = image.base64EncodedString()
            imageStrings.append(base64String)
          }
          messageData["images"] = imageStrings
        }
        messages.append(messageData)
      }
      db.collection("users").document(uId).collection("conversations").document(self.session).setData(["messages": messages])
    }
  }
  
  func triggerChatAPI(input: String, userId: String, completion: @escaping (String) -> Void)  {
    guard let url = URL(string: Secrets.chatAPI) else {
      print("Invalid URL")
      completion("Invalid URL")
      return
    }
    
    let requestData = ChatRequest(
      input: input,
      assistantId: "E7B8A9C6_D5E4_4567_8901_234567890JKL",
      userId: userId,
      threadId: session
    )
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    do {
      request.httpBody = try JSONEncoder().encode(requestData)
    } catch {
      print("Failed to encode request: \(error)")
      completion("Failed to encode request: \(error)")
      return
    }
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      if let error = error {
        print("Request failed: \(error)")
        completion("Request failed: \(error)")
        return
      }
      
      guard let data = data else {
        print("No data received")
        completion("No data received")
        return
      }
      
      if let responseString = String(data: data, encoding: .utf8) {
        print("Response: \(responseString)")
        completion(responseString)
      } else {
        print("Failed to decode response data into a string")
        completion("Failed to decode response data into a string")
      }
    }
    
    task.resume()
  }
  
  func startNewChat() {
    conversation.removeAll()
    session = UUID().uuidString
  }
}
