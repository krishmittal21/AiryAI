//
//  ConversationRowView.swift
//  AiryAI
//
//  Created by Krish Mittal on 23/03/24.
//

import SwiftUI

struct ConversationRowView: View {
    @Environment(\.colorScheme) var colorScheme
    let conversation: [ChatMessage]
    
    var body: some View {
        HStack {
            if let firstMessage = conversation.first {
                Text(firstMessage.message)
            } else {
                Text("Untitled")
            }
            Spacer()
            Image(systemName: "arrow.forward")
        }
        .bold()
        .multilineTextAlignment(.leading)
        .foregroundStyle(colorScheme == .dark ? .white : .black)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(15)
        .background(colorScheme == .dark ? .black : .white)
        .cornerRadius(8)
        .shadow(color: colorScheme == .dark ? Color.white.opacity(0.2) : Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}

