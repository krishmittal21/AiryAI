//
//  ContentView.swift
//  AiryAI
//
//  Created by Krish Mittal on 21/03/24.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel = AuthenticationViewModel()
    @State private var selectedTab: Tab = .chat
    @State private var isSettingsViewPresented = false
    
    enum Tab {
        case chat, assistant, history
    }
    
    var tabTitle: String {
        switch selectedTab {
        case .chat:
            return "AiryAI - Chat"
        case .assistant:
            return "AiryAI - Assistant"
        case .history:
            return "AiryAI - History"
        }
    }
    
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
            TabView(selection: $selectedTab) {
                Group {
                    ChatView()
                        .tabItem {Label("Chat", systemImage: "message")}
                        .tag(Tab.chat)
                    AssistantView()
                        .tabItem {Label("Assistant", systemImage: "square.grid.2x2.fill")}
                        .tag(Tab.assistant)
                    ChatHistoryView()
                        .tabItem {Label("History", systemImage: "clock")}
                        .tag(Tab.history)
                }
                .toolbarBackground(Color.backgroundColor, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
            }
            .toolbar(.visible, for: .navigationBar)
            .toolbarBackground(Color.backgroundColor, for: .navigationBar)
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        Image("logo-transparent")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding(.leading, 10)
                        Text(tabTitle)
                            .font(.headline)
                            .foregroundColor(.primary)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isSettingsViewPresented = true
                    } label: {
                        Image(systemName: "gearshape.fill")
                    }
                }
            }
            .sheet(isPresented: $isSettingsViewPresented) {
                SettingsView()
            }
        }
    }
}

#Preview {
    MainView()
}
