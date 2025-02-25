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
    @Published var hingeText = ""
    @Published var outputRizz = ""
    @Published var emailType = "New Email"
    @Published var rizzType = "Initial Prompt"
    let initialMessage = "Write a reply to this hinge prompt: "
    let replyMessage = "Carry on the conversation: "
    let newEmailPrompt = "Write an email on this topic/subject: "
    let replyEmailPrompt = "Write an email replying to this email: "
    @Published var translationText = ""
    @Published var translationResult = ""
    @Published var translationLangugae = "Hindi"
}

extension AssistantViewModel {
  
  func sendMessages() {
    guard let uId = Auth.auth().currentUser?.uid else { return }
    
    triggerChatAPI(input: hingeText, userId: uId) { text in
      print("rizz: \(text)")
      DispatchQueue.main.async {
        self.outputRizz = text
      }
    }
  }
  
  func triggerChatAPI(input: String, userId: String, completion: @escaping (String) -> Void)  {
    guard let url = URL(string: Secrets.chatAPI) else {
      print("Invalid URL")
      completion("Invalid URL")
      return
    }
    
    let requestData = ChatRequest(
      input: "\(rizzType) \(input)",
      assistantId: "H2G3F4E5_D6C7_8910_2345_6789012JKLQ",
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
