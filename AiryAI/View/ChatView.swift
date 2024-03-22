//
//  ChatView.swift
//  AiryAI
//
//  Created by Krish Mittal on 22/03/24.
//

import SwiftUI

struct ChatView: View {
    @State private var userText: String = ""
    var body: some View {
        VStack{
            Spacer()
            Text("Welcome to AiryAI")
            Spacer()
            HStack{
                Button{
                    
                } label: {
                    Image(systemName: "camera").imageScale(.large)
                }
                Button{
                    
                } label: {
                    Image(systemName: "photo").imageScale(.large)
                }
                TextField("Talk with AiryAI", text: $userText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                Button{
                    
                } label: {
                    Image(systemName: "mic").imageScale(.large)
                }
            }
            .padding()
        }
    }
}

#Preview {
    ChatView()
}
