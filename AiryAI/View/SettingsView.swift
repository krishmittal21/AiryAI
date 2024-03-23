//
//  SettingsView.swift
//  AiryAI
//
//  Created by Krish Mittal on 22/03/24.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var viewModel = AuthenticationViewModel()
    var body: some View {
        Button{
            viewModel.signOut()
        } label: {
            Text("log out")
        }
    }
}

#Preview {
    SettingsView()
}
