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
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
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
                        .bold()
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
                .padding()
            }
            .navigationTitle("Email")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.red)
                    }
                }
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
