//
//  RizzAssistantView.swift
//  AiryAI
//
//  Created by Krish Mittal on 30/03/24.
//

import SwiftUI

struct RizzAssistantView: View {
    @StateObject private var assistantViewModel = AssistantViewModel()
    @State private var subheading = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack { VStack { Divider() } }
                Menu {
                    Button {
                        assistantViewModel.rizzType = "Initial Prompt"
                    } label: {
                        Text("Initial Prompt")
                    }
                    Button {
                        assistantViewModel.rizzType = "Carry on the conversation: "
                    } label: {
                        Text("Carry on the conversation")
                    }
                } label: {
                    Text("Action: " + assistantViewModel.rizzType)
                    Spacer()
                    Image(systemName: "arrow.down")
                        .bold()
                }
                .foregroundStyle(.primary)
                .padding(.horizontal)
                HStack { VStack { Divider() } }
                let placeHoler = assistantViewModel.rizzType == "Initial Prompt" ? "Whats her prompt: " : "Enter her message"
                TextField(placeHoler, text: $subheading, axis: .vertical)
                    .lineLimit(2...)
                    .font(.subheadline)
                    .textFieldStyle(.plain)
                    .padding()
                ScrollView {
                  Text(assistantViewModel.outputRizz)
                }
                .padding()
            }
            .navigationTitle("HingeRizz")
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
                          assistantViewModel.hingeText = subheading
                          assistantViewModel.sendMessages()
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
    RizzAssistantView()
}
