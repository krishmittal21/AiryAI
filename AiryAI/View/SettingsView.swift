//
//  SettingsView.swift
//  AiryAI
//
//  Created by Krish Mittal on 22/03/24.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var auth = Authentication()
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    @State var showTerms:Bool = false
    @State var showPrivacy:Bool = false
    @State var showHelp:Bool = false
    
    var body: some View {
        NavigationStack {
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
//                        HStack {
//                            Image(systemName: "arrow.up.circle")
//                            Text("Upgrade Your Subscription")
//                        }
//                        .foregroundStyle(.blue)
                    } header: {
                        Text("Account")
                    }
                    Section {
                        HStack {
                            Image(systemName: "questionmark.circle")
                            Text("Help Center")
                        }
                        .onTapGesture {
                            showHelp = true
                        }
                        HStack {
                            Image(systemName: "book.closed")
                            Text("Terms of Use")
                        }
                        .onTapGesture {
                            showTerms = true
                        }
                        HStack {
                            Image(systemName: "lock")
                            Text("Privacy Policy")
                        }
                        .onTapGesture {
                            showPrivacy = true
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
                    Section {
                        HStack {
                            Image(systemName: "x.circle")
                            Text("Delete Account")
                        }
                        .foregroundStyle(.red)
                        .onTapGesture {
                            auth.delete()
                        }
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.red)
                    }
                    
                }
            }
            .onAppear {
                auth.fetchUser()
            }
            .sheet(isPresented: $showHelp, content: {
                HelpView()
            })
            .sheet(isPresented: $showTerms, content: {
                TermsofUseView()
            })
            .sheet(isPresented: $showPrivacy, content: {
                PrivacyView()
            })
        }
    }
}

#Preview {
    SettingsView()
}
