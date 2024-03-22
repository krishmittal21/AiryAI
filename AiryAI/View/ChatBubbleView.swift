//
//  ChatBubbleView.swift
//  AiryAI
//
//  Created by Krish Mittal on 22/03/24.
//

import SwiftUI

struct ChatBubbleView<Content>: View where Content: View {
    let direction: ChatBubbleShape.Direction
    let content: () -> Content
    init(direction: ChatBubbleShape.Direction, @ViewBuilder content: @escaping () -> Content) {
            self.content = content
            self.direction = direction
    }
    var body: some View {
        HStack {
            if direction == .right {
                Spacer()
            }
            content()
                .clipShape(ChatBubbleShape(direction: direction))
            if direction == .left {
                Spacer()
            }
        }
        .padding(10)
    }
}
