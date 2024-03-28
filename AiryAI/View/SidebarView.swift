//
//  SidebarView.swift
//  AiryAI
//
//  Created by Krish Mittal on 26/03/24.
//

import SwiftUI

struct SidebarView: View {
    @StateObject private var chatHistory = ChatHistory()
    @State private var showMenu: Bool = false
    @State private var selectedTab: Tab = .AiryAI
    @State private var selectedConversation: [ChatMessage]?
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        Sidebar(showMenu: $showMenu) { safeArea in
            NavigationView {
                VStack {
                    if let selectedConversation = selectedConversation {
                        ChatConversationMessageView(conversation: selectedConversation)
                    } else {
                        switch selectedTab {
                        case .AiryAI:
                            ChatView()
                        case .Assistant:
                            AssistantView()
                        case .Settings:
                            SettingsView()
                        }
                    }
                }
                .navigationTitle(selectedTab.title)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: { showMenu.toggle() }, label: {
                            Image(systemName: showMenu ? "xmark" : "line.3.horizontal")
                                .foregroundStyle(Color.primary)
                                .contentTransition(.symbolEffect)
                        })
                    }
                }
                .onAppear {
                    chatHistory.fetchConversations()
                }
            }
        } menuView: { safeArea in
            SideBarMenuView(safeArea, selectedTab: $selectedTab)
                .background(colorScheme == .light ? Color.white : Color.black)
        }
    }
    
    @ViewBuilder
    func SideBarMenuView(_ safeArea: UIEdgeInsets, selectedTab: Binding<Tab>) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(Tab.allCases, id: \.self) { tab in
                SideBarButton(tab, isSelected: tab == selectedTab.wrappedValue) {
                    selectedTab.wrappedValue = tab
                    if (selectedConversation != nil) {
                        selectedConversation = nil
                    }
                }
            }
            ScrollView {
                VStack {
                    ForEach(chatHistory.conversations, id: \.self) { conversation in
                        Button(action: {
                            selectedConversation = conversation
                        }) {
                            ConversationRowView(conversation: conversation)
                        }
                    }
                }
            }
            
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 20)
        .padding(.top, safeArea.top)
        .padding(.bottom, safeArea.bottom)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
    
    @ViewBuilder
    func SideBarButton(_ tab: Tab, isSelected: Bool, onTap: @escaping () -> () = { }) -> some View {
        Button(action: onTap, label: {
            HStack(spacing: 12) {
                if tab == .AiryAI {
                    Image("logo-transparent")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                } else {
                    Image(systemName: tab.rawValue)
                        .font(.title3)
                }
                Text(tab.title)
                    .font(.callout)
                Spacer(minLength: 0)
            }
            .foregroundColor(colorScheme == .light ? .black : .white)
            .padding(.vertical, 10)
            .padding(.horizontal,10)
            .contentShape(.rect)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(isSelected && selectedConversation == nil ? Color.gray.opacity(0.2) : Color.clear)
            )
        })
    }
    
    enum Tab: String, CaseIterable {
        case AiryAI = "logo-transparent"
        case Assistant = "square.grid.2x2"
        case Settings = "gearshape.fill"
        
        var title: String {
            switch self {
            case .AiryAI: return "AiryAI"
            case .Assistant: return "Assistants"
            case .Settings: return "Settings"
            }
        }
    }
}


#Preview {
    SidebarView()
}
