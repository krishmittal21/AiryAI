//
//  AiryAIApp.swift
//  AiryAI
//
//  Created by Krish Mittal on 21/03/24.
//

import SwiftUI
import FirebaseCore

@main
struct AiryAIApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
