//
//  ChatHistoryViewModel.swift
//  AiryAI
//
//  Created by Krish Mittal on 23/03/24.
//

import Foundation
import Firebase
import FirebaseFirestore

class ChatHistory: ObservableObject {
    @Published var conversations = [[ChatMessage]]()
    private var listener: ListenerRegistration?

    init() {
        fetchConversations()
    }

    func fetchConversations() {
        let db = Firestore.firestore()
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }

        listener = db.collection("users").document(uId).collection("conversations")
            .addSnapshotListener { [weak self] querySnapshot, error in
                guard let self = self else { return }
                if let error = error {
                    print("Error fetching conversations: \(error.localizedDescription)")
                    return
                }

                var fetchedConversations = [[ChatMessage]]()

                for document in querySnapshot?.documents ?? [] {
                    guard let data = document.data()["messages"] as? [[String: Any]] else {
                        continue
                    }

                    var conversation = [ChatMessage]()

                    for messageData in data {
                        if let roleString = messageData["role"] as? String,
                           let role = ChatRole.fromString(roleString),
                           let message = messageData["message"] as? String {

                            var images: [Data]?
                            if let imageStrings = messageData["images"] as? [String] {
                                images = imageStrings.compactMap { Data(base64Encoded: $0) }
                            }

                            let chatMessage = ChatMessage(role: role, message: message, images: images)
                            conversation.append(chatMessage)
                        }
                    }

                    fetchedConversations.append(conversation)
                }

                DispatchQueue.main.async {
                    self.conversations = fetchedConversations
                }
            }
    }
}
