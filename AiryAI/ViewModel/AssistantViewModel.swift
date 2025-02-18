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
    @Published var emailType = "New Email"
    let newEmailPrompt = "Write an email on this topic/subject: "
    let replyEmailPrompt = "Write an email replying to this email: "
    @Published var translationText = ""
    @Published var translationResult = ""
    @Published var translationLangugae = "Hindi"
}

extension AssistantViewModel {
    
    func translation() async {
        do {
            let prompt = "Translate this text: " + translationText + "to" + translationLangugae
            for try await response in proModel.generateContentStream(prompt) {
                translationResult += response.text!
            }
        } catch {
            print("Error generating translation: \(error.localizedDescription)")
        }
    }
    func saveTranslation() {
        let db = Firestore.firestore()
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        let translationData = [
            "translationText": translationText,
            "result": translationResult
        ]
        db.collection("users").document(uId).collection("translations").document(session).setData(translationData) { error in
            if let error = error {
                print("Error saving translation: \(error.localizedDescription)")
            } else {
                print("TranslationData saved successfully")
            }
        }
    }
}

extension AssistantViewModel {
    
    func writeEmail() async {
        do {
            let prompt = emailType == "New Email" ? newEmailPrompt + emailText : replyEmailPrompt + emailText
            for try await response in proModel.generateContentStream(prompt) {
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
