//
//  PrivacyView.swift
//  AiryAI
//
//  Created by Krish Mittal on 01/04/24.
//

import SwiftUI

struct PrivacyView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Privacy Policy")
                    .font(.title)
                    .bold()

                Text("AiryAI takes your privacy seriously. This Privacy Policy outlines how we collect and use your information.")

                Text("1. Information We Collect")
                    .bold()
                Text("We collect your name, email address, and the chat history between you and the AI model. We do not collect any other personal or device information.")

                Text("2. Use of Information")
                    .bold()
                Text("We use the collected information solely to provide and improve our chat services. Your chat history is used to display your previous conversations within the app.")

                Text("3. Data Sharing and Disclosure")
                    .bold()
                Text("We do not sell, rent, or share your personal information or chat history with any third parties.")

                Text("4. Data Security")
                    .bold()
                Text("We implement appropriate security measures to protect your information from unauthorized access or disclosure.")

                Text("5. Changes to This Privacy Policy")
                    .bold()
                Text("We may update this Privacy Policy from time to time. We encourage you to review the policy periodically for any changes.")

                Text("By using AiryAI, you consent to the collection and use of your information as described in this Privacy Policy.")
            }
            .padding()
        }
    }
}

#Preview {
    PrivacyView()
}
