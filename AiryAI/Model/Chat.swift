//
//  Chat.swift
//  AiryAI
//
//  Created by Krish Mittal on 22/03/24.
//

import Foundation

enum ChatRole {
    case user
    case model
}

struct ChatMessage: Identifiable, Equatable {
    let id = UUID().uuidString
    var role: ChatRole
    var message: String
    var images: [Data]?
}
