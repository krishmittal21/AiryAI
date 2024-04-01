//
//  ChatConversationView.swift
//  AiryAI
//
//  Created by Krish Mittal on 23/03/24.
//

import SwiftUI

struct ConversationMessageView: View {
    var conversation: [ChatMessage]
    var body: some View {
        ScrollView {
            VStack {
                ForEach(conversation, id: \.id) { message in
                    if let images = message.images, !images.isEmpty {
                        ScrollView(.horizontal) {
                            LazyHStack(spacing: 10) {
                                ForEach(images.indices, id: \.self) { index in
                                    Image(uiImage: UIImage(data: images[index])!)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 150)
                                        .clipShape(RoundedRectangle(cornerRadius: 5))
                                        .containerRelativeFrame(.horizontal)
                                }
                            }
                            .scrollTargetLayout()
                        }
                        .frame(width: 100, height: 100)
                    }
                    ChatBubbleView(direction: message.role == .model ? .left : .right) {
                        Text(message.message)
                            .font(.subheadline)
                            .padding(15)
                            .background(message.role == .model ? Color.modelChatColor : Color.userChatColor)
                    }
                }
            }
        }
    }
}

