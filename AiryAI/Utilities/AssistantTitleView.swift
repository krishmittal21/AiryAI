//
//  AssistantTitleView.swift
//  AiryAI
//
//  Created by Krish Mittal on 30/03/24.
//

import SwiftUI

struct AssistantTileView: View {
    let title: String
    let subtitle: String
    let number: String
    let action: () -> Void
    @Environment(\.colorScheme) var colorScheme
    
    private let foregroundColor: Color = .black
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(number + ".")
                    .bold()
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .bold()
                        .font(.headline)
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                    Text(subtitle)
                        .font(.caption)
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                }
                .padding(.horizontal, 8)
                Spacer()
            }
            .padding()
        }
        .padding()
        .frame(width: 370, height: 100)
    }
}
