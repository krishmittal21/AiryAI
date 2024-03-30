//
//  EmailAssistantView.swift
//  AiryAI
//
//  Created by Krish Mittal on 30/03/24.
//

import SwiftUI

struct EmailAssistantView: View {
    @StateObject private var assistantViewModel = AssistantViewModel()
    @State private var emailSubject = ""

    var body: some View {
        VStack {
            TextField("Enter email subject", text: $emailSubject)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                Task {
                    assistantViewModel.emailText = emailSubject
                    await assistantViewModel.writeEmail()
                }
            }) {
                Text("Generate Email")
            }
            .padding()
            
            ScrollView {
                Text(assistantViewModel.outputEmail)
            }

            Spacer()
        }
        .padding()
    }
}

#Preview {
    EmailAssistantView()
}
