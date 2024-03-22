//
//  ChatView.swift
//  AiryAI
//
//  Created by Krish Mittal on 22/03/24.
//

import SwiftUI
import GoogleGenerativeAI

struct ChatView: View {
    @State private var userText: String = ""
    @State var output: String = ""
    let model = GenerativeModel(name: "gemini-pro", apiKey: APIKey.default)
    var body: some View {
        VStack{
            Spacer()
            ScrollView{
                Text(output)
            }
            .padding()
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
                Button{
                    Task {
                        let response = try await model.generateContent(userText)
                        if let text = response.text {
                            output = text
                        }
                    }
                } label: {
                    Image(systemName: "paperplane")
                }
            }
            .padding()
        }
    }
}

#Preview {
    ChatView()
}
