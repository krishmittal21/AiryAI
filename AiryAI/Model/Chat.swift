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
    
    static func fromString(_ string: String) -> ChatRole? {
        switch string {
        case "user":
            return .user
        case "model":
            return .model
        default:
            return nil
        }
    }
}

struct ChatMessage: Identifiable, Equatable, Hashable {
    let id = UUID().uuidString
    var role: ChatRole
    var message: String
    var images: [Data]?
}
