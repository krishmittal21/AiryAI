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
        NavigationView {
            VStack {
                HStack { VStack { Divider() } }
                Menu {
                    Button {
                        assistantViewModel.emailType = "New Email"
                    } label: {
                        Text("New Email")
                    }
                    Button {
                        assistantViewModel.emailType = "Reply"
                    } label: {
                        Text("Reply")
                    }
                } label: {
                    Text("Action: " + assistantViewModel.emailType)
                    Spacer()
                    Image(systemName: "arrow.down")
                }
                .foregroundStyle(.primary)
                .padding(.horizontal)
                HStack { VStack { Divider() } }
                let placeHoler = assistantViewModel.emailType == "New Email" ? "What topic or subject would you like to\n write about? " : "Enter the email your received and describe how you would like your response"
                TextField(placeHoler, text: $emailSubject, axis: .vertical)
                    .lineLimit(2...)
                    .font(.subheadline)
                    .textFieldStyle(.plain)
                    .padding()
                ScrollView {
                    Text(assistantViewModel.outputEmail)
                }
            }
            .navigationTitle("Email")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        Task {
                            assistantViewModel.emailText = emailSubject
                            await assistantViewModel.writeEmail()
                        }
                    }) {
                        Text("SUBMIT")
                            .foregroundStyle(.yellow)
                            .bold()
                    }
                }
            }
            
        }
    }
}

#Preview {
    EmailAssistantView()
}
