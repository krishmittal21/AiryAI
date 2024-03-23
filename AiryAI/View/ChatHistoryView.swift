//
//  ChatHistoryView.swift
//  AiryAI
//
//  Created by Krish Mittal on 22/03/24.
//

import SwiftUI

struct ChatHistoryView: View {
    @StateObject private var viewModel = ChatHistoryViewModel()
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.conversations, id: \.self) { conversation in
                    NavigationLink(destination: ChatHistoryConversationView(conversation: conversation)){
                        if let firstMessage = conversation.first {
                            let words = firstMessage.message.components(separatedBy: " ")
                            let displayText = words.prefix(3).joined(separator: " ")
                            Text(displayText + " ..")
                                .fontWeight(.medium)
                        } else {
                            Text("Untitled")
                        }
                    }
                }.listRowSeparator(.hidden)
            }
            .listSectionSeparator(.hidden)
            .padding()
            .onAppear {
                viewModel.fetchConversations()
            }
        }
    }
}

#Preview {
    ChatHistoryView()
}
