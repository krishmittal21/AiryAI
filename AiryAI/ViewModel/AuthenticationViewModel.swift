//
//  AuthenticationViewModel.swift
//  AiryAI
//
//  Created by Krish Mittal on 21/03/24.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth

enum AuthenticationState {
    case unauthenticated
    case authenticating
    case authenticated
}

@MainActor
class AuthenticationViewModel: ObservableObject{
    
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var authenticationState: AuthenticationState = .unauthenticated
    @Published var isValid: Bool  = false
    @Published var errorMessage: String = ""
    @Published var currentUserId: String = ""
    @Published var user: AAIUser? = nil
    
    private var handler: AuthStateDidChangeListenerHandle?
    
    init(){
        self.handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.currentUserId = user?.uid ?? ""
            }
        }
    }
    
    private func insertUserRecord(id: String) {
        
        let newUser = AAIUser(id: id, name: name, email: email, joined: Date().timeIntervalSince1970)
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary())
    }
    
    public var isSignedIn: Bool{
        return Auth.auth().currentUser != nil
    }
}

extension AuthenticationViewModel {
    
    func signInWithEmailPassword() async -> Bool {
        do {
            let result = try await Auth.auth().signIn(withEmail: self.email, password: self.password)
            name = result.user.displayName ?? ""
            email = result.user.email ?? ""
            return true
        }
        catch  {
            print(error)
            errorMessage = error.localizedDescription
            return false
        }
    }
    
    func signUpWithEmailPassword() async -> Bool {
        
        authenticationState = .authenticating
        
        guard validate() else {
            return false
        }
        
        do  {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            do {
                try await result.user.sendEmailVerification()
                print("Verification email sent successfully!")
            } catch {
                print("Error sending verification email: \(error.localizedDescription)")
            }
            insertUserRecord(id: currentUserId)
            
            return true
        }
        catch {
            print(error)
            errorMessage = error.localizedDescription
            authenticationState = .unauthenticated
            return false
        }
    }
    
    func passwordReset(){
        Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func fetchUser(){
        
        let db = Firestore.firestore()
        db.collection("users").document(currentUserId).getDocument { [weak self] snapshot, error in
            guard let data = snapshot?.data(), error == nil else {
                return
            }
            DispatchQueue.main.async {
                self?.user = AAIUser(
                    id: data["id"] as? String ?? "",
                    name: data["name"] as? String ?? "",
                    email: data["email"] as? String ?? "",
                    joined: data["joined"] as? TimeInterval ?? 0
                )
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        }
        catch {
            print(error)
            errorMessage = error.localizedDescription
        }
    }
    
    func validate() -> Bool {
        errorMessage = ""
        
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty else{
            return false
        }
        
        let emailRegex = #"^[a-zA-Z0-9._%+-]+@(gmail|yahoo|outlook|icloud)\.(com|net|org|edu)$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        guard emailPredicate.evaluate(with: email) else {
            errorMessage = "Please enter a valid email address from Google, Yahoo, Outlook, or iCloud."
            return false
        }
        
        let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*?[0-9])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        guard passwordPredicate.evaluate(with: password) else {
            errorMessage = "Password must be at least 8 characters long and contain at least one letter and one number."
            return false
        }
        
        guard password == confirmPassword else{
            errorMessage = "Passwords Dont Match"
            return false
        }
        
        return true
    }
}
