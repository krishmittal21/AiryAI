//
//  HelpView.swift
//  AiryAI
//
//  Created by Krish Mittal on 01/04/24.
//

import SwiftUI

struct HelpView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Help")
                    .font(.title)
                    .bold()

                Text("Welcome to AiryAI! This help section provides information and guidelines to assist you in using our chat application effectively.")

                Text("1. Getting Started")
                    .bold()
                Text("To begin, simply open the app and start typing your message in the chat input field. You can also send images along with your text messages.")

                Text("2. Voice Input")
                    .bold()
                Text("AiryAI supports voice input for your convenience. Tap the microphone icon in the chat input area and speak your message. The app will transcribe your speech and send it to the AI model for processing.")

                Text("3. AI Responses")
                    .bold()
                Text("AiryAI utilizes the Gemini API to provide conversational AI capabilities. The AI model will process your input and generate relevant responses based on its training.")

                Text("4. Conversation History")
                    .bold()
                Text("Your chat history is automatically saved and can be accessed through the sidebar menu. You can review previous conversations or start a new chat at any time.")

                Text("5. Settings and Preferences")
                    .bold()
                Text("Customize your experience by accessing the settings from the sidebar menu. You can adjust various preferences and manage your account settings.")

                Text("6. Support")
                    .bold()
                Text("If you encounter any issues or have questions, please contact our support team at krishmittal212005@gmail.com. We're here to help you make the most of our app.")

                Text("Enjoy your conversation with AiryAI!")
            }
            .padding()
        }
    }
}

#Preview {
    HelpView()
}
