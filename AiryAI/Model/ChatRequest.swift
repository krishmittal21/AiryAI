//
//  ChatRequest.swift
//  AiryAI
//
//  Created by Krish Mittal on 17/02/25.
//

import Foundation

struct ChatRequest: Codable {
    let input: String
    let assistantId: String
    let userId: String
    let threadId: String
}
