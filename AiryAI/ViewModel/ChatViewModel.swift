//
//  ChatViewModel.swift
//  AiryAI
//
//  Created by Krish Mittal on 22/03/24.
//

import SwiftUI
import GoogleGenerativeAI
import Firebase
import FirebaseFirestore

class ChatViewModel: ObservableObject {
    private var userId = ""
    private var proModel = GenerativeModel(name: "gemini-pro", apiKey: APIKey.default)
    private var proVisionModel = GenerativeModel(name: "gemini-pro-vision", apiKey: APIKey.default)
    private(set) var conversation = [ChatMessage]()
    @Published var session = UUID().uuidString
    
    func sendMessages(message: String, imageData: [Data]) async {
        conversation.append(.init(role: .user, message: message, images: imageData))
        conversation.append(.init(role: .model, message: "",images: nil))
        do {
            let chatModel = imageData.isEmpty ? proModel : proVisionModel
            var images = [PartsRepresentable]()
            for data in imageData {
                if let compressedData = UIImage(data: data)?.jpegData(compressionQuality: 0.1) {
                    images.append(ModelContent.Part.jpeg(compressedData))
                }
            }
            let outputStream = chatModel.generateContentStream(message,images)
            for try await chunk in outputStream {
                guard let text = chunk.text else {
                    return
                }
                let lastChatMessageIndex = conversation.count - 1
                conversation[lastChatMessageIndex].message += text
            }
        }
        catch {
            conversation.removeLast()
            conversation.append(.init(role: .model, message: "Something went wrong. Please try again"))
            print(error.localizedDescription)
        }
    }
    
    func saveMessages() {
        let db = Firestore.firestore()
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        var messages = [[String: Any]]()
        for message in conversation {
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
        db.collection("users").document(uId).collection("conversations").document(session).setData(["messages": messages])
        
    }
    
    func startNewChat() {
        conversation.removeAll()
        session = UUID().uuidString
    }
}
