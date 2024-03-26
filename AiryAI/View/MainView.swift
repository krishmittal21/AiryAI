//
//  ContentView.swift
//  AiryAI
//
//  Created by Krish Mittal on 21/03/24.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel = AuthenticationViewModel()

    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            SidebarView()
        } else {
            LoginView()
        }
    }
}

#Preview {
    MainView()
}
