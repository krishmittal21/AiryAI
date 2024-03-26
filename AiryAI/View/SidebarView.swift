//
//  SidebarView.swift
//  AiryAI
//
//  Created by Krish Mittal on 26/03/24.
//

import SwiftUI

struct SidebarView: View {
    @State private var showMenu: Bool = false
    @State private var selectedTab: Tab = .AiryAI
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        Sidebar(showMenu: $showMenu) { safeArea in
            NavigationView {
                VStack {
                    switch selectedTab {
                    case .AiryAI:
                        ChatView()
                    case .Assistant:
                        AssistantView()
                    case .History:
                        ChatHistoryView()
                    case .Settings:
                        SettingsView()
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
                    .fill(isSelected ? Color.gray.opacity(0.2) : Color.clear)
            )
        })
    }
    
    enum Tab: String, CaseIterable {
        case AiryAI = "logo-transparent"
        case Assistant = "square.grid.2x2"
        case History = "clock"
        case Settings = "gearshape.fill"
        
        var title: String {
            switch self {
            case .AiryAI: return "AiryAI"
            case .Assistant: return "Assistants"
            case .History: return "History"
            case .Settings: return "Settings"
            }
        }
    }
}


#Preview {
    SidebarView()
}
