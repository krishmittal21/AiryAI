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
            accountView
        } else {
            LoginView()
        }
    }
    
    @ViewBuilder
    var accountView: some View {
        NavigationView {
            TabView {
                Group {
                    ChatView()
                        .tabItem {Label("Chat", systemImage: "message")}
                    AssistantView()
                        .tabItem {Label("Assistant", systemImage: "square.grid.2x2.fill")}
                    ChatHistoryView()
                        .tabItem {Label("History", systemImage: "clock")}
                }
                .toolbarBackground(Color.backgroundColor, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
            }
        }
    }
}

#Preview {
    MainView()
}
