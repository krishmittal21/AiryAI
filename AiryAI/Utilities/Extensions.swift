//
//  Extensions.swift
//  AiryAI
//
//  Created by Krish Mittal on 21/03/24.
//

import SwiftUI

extension Color {
    static let primaryColor = Color("CustomBlueColor")
    static let backgroundColor = Color("BackgroundColor")
    static let modelChatColor = Color("ModelChatColor")
    static let userChatColor = Color("UserChatColor")
}

extension Encodable {
    func asDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else {
            return [:]
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            return json ?? [:]
        } catch {
            return [:]
        }
    }
}
