//
//  TermsofUseView.swift
//  AiryAI
//
//  Created by Krish Mittal on 01/04/24.
//

import SwiftUI

struct TermsofUseView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Terms of Use")
                    .font(.title)
                    .bold()

                Text("Welcome to AiryAI! By using our app, you agree to the following terms and conditions:")

                Text("1. Use of the App")
                    .bold()
                Text("AiryAI is a chat application that utilizes the Gemini API to provide conversational AI capabilities. The app is intended for personal and non-commercial use only.")

                Text("2. User Content")
                    .bold()
                Text("You are solely responsible for the content you send through the app, including text and images. AiryAI reserves the right to remove or block any content that violates our policies or applicable laws.")

                Text("3. Data Collection and Use")
                    .bold()
                Text("AiryAI collects your name, email address, and the chat history between you and the AI model. This information is used solely to provide and improve our chat services and to display your previous conversations within the app. We do not collect any other personal or device information, and we do not sell, rent, or share your information with third parties.")

                Text("4. Intellectual Property")
                    .bold()
                Text("AiryAI and its licensors own all intellectual property rights in the app and its underlying technology. You may not modify, reproduce, distribute, or create derivative works of the app without our prior written consent.")

                Text("5. Limitation of Liability")
                    .bold()
                Text("AiryAI is provided on an 'as is' and 'as available' basis. We do not guarantee the accuracy, reliability, or availability of the app or its services.")

                Text("6. Termination")
                    .bold()
                Text("AiryAI reserves the right to terminate or suspend your access to the app at any time, without notice and for any reason.")

                Text("By using AiryAI, you acknowledge that you have read, understood, and agreed to these Terms of Use.")
            }
            .padding()
        }
    }
}

#Preview {
    TermsofUseView()
}
