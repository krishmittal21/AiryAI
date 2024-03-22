//
//  ChatViewModel.swift
//  AiryAI
//
//  Created by Krish Mittal on 22/03/24.
//

import SwiftUI
import GoogleGenerativeAI

class ChatViewModel: ObservableObject {
    private var proModel = GenerativeModel(name: "gemini-pro", apiKey: APIKey.default)
    private var proVisionModel = GenerativeModel(name: "gemini-pro-vision", apiKey: APIKey.default)
    private(set) var messages = [ChatMessage]()
    func sendMessages(message: String, imageData: [Data]) async {
        messages.append(.init(role: .user, message: message, images: imageData))
        messages.append(.init(role: .model, message: "",images: nil))
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
                let lastChatMessageIndex = messages.count - 1
                messages[lastChatMessageIndex].message += text
            }
        }
        catch {
            messages.removeLast()
            messages.append(.init(role: .model, message: "Something went wrong. Please try again"))
            print(error.localizedDescription)
        }
    }
}
