//
//  SettingsView.swift
//  AiryAI
//
//  Created by Krish Mittal on 22/03/24.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var auth = AuthenticationViewModel()
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section {
                        HStack {
                            Image(systemName: "envelope")
                            Text("Email")
                            Spacer()
                            if let user = auth.user {
                                Text(user.email)
                                    .foregroundStyle(.gray)
                            } else {
                                Text("Loading Profile ..")
                                    .foregroundStyle(.gray)
                            }
                        }
                        HStack {
                            Image(systemName: "plus.app")
                            Text("Subscription")
                            Spacer()
                            Text("Basic Plan")
                                .foregroundStyle(.gray)
                        }
                        HStack {
                            Image(systemName: "arrow.up.circle")
                            Text("Upgrade Your Subscription")
                        }
                        .foregroundStyle(.blue)
                    } header: {
                        Text("Account")
                    }
                    Section {
                        HStack {
                            Image(systemName: "questionmark.circle")
                            Text("Help Center")
                        }
                        HStack {
                            Image(systemName: "book.closed")
                            Text("Terms of Use")
                        }
                        HStack {
                            Image(systemName: "lock")
                            Text("Privacy Policy")
                        }
                    } header: { 
                        Text("About")
                    }
                    Section {
                        HStack {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                            Text("Sign out")
                        }
                        .foregroundStyle(.red)
                        .onTapGesture {
                            auth.signOut()
                        }
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                auth.fetchUser()
            }
        }
    }
}

#Preview {
    SettingsView()
}
