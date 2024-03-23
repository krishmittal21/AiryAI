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
            ScrollView {
                VStack {
                    ForEach(viewModel.conversations, id: \.self) { conversation in
                        NavigationLink(destination: ChatHistoryConversationView(conversation: conversation).padding()){
                            ConversationRowView(conversation: conversation)
    
                        }
                    }
                }
                .padding()
            }
            .padding()
            .scrollContentBackground(.hidden)
            .onAppear {
                viewModel.fetchConversations()
            }
        }
    }
}

