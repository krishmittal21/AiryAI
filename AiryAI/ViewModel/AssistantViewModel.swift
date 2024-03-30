//
//  AssistantViewModel.swift
//  AiryAI
//
//  Created by Krish Mittal on 30/03/24.
//

import Foundation
import GoogleGenerativeAI
import Firebase
import FirebaseFirestore

@MainActor
class AssistantViewModel: ObservableObject {
    private var userId = ""
    @Published var session = UUID().uuidString
    private var proModel = GenerativeModel(name: "gemini-pro", apiKey: APIKey.default)
    private var proVisionModel = GenerativeModel(name: "gemini-pro-vision", apiKey: APIKey.default)
    @Published var emailText = ""
    @Published var outputEmail = ""
    let emailPrompt = "Write an email on this topic/subject: "
}

extension AssistantViewModel {
    
    func writeEmail() async {
        do {
            for try await response in proModel.generateContentStream(emailPrompt + emailText) {
                outputEmail += response.text!
            }
        } catch {
            print("Error generating email: \(error.localizedDescription)")
        }
        saveEmail()
    }
    
    func saveEmail() {
        let db = Firestore.firestore()
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        let emailData = [
            "subject": emailText,
            "content": outputEmail
        ]
        db.collection("users").document(uId).collection("emails").document(session).setData(emailData) { error in
            if let error = error {
                print("Error saving email: \(error.localizedDescription)")
            } else {
                print("Email saved successfully")
            }
        }
    }
}
