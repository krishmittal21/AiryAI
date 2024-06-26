//
//  LoginView.swift
//  AiryAI
//
//  Created by Krish Mittal on 21/03/24.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @StateObject var viewModel = Authentication()
    @State var isSignupView = false
    
    private func signInWithEmailPassword() {
        Task {
            await viewModel.signInWithEmailPassword()
        }
    }
    
    private func signInWithGoogle() {
            Task {
              if await viewModel.signInWithGoogle() == true {
              }
            }
        }
    
    var body: some View {
        NavigationStack{
            
            VStack{
                Image("logo-transparent")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minHeight: 200, maxHeight: 400)
            
                VStack {
                    VStack{
                        Text("Login")
                            .bold()
                            .font(.title)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom,20)
                        
                        HStack {
                            Image(systemName: "at")
                            TextField("Email", text: $viewModel.email)
                                .textInputAutocapitalization(.never)
                                .disableAutocorrection(true)
                                .submitLabel(.next)
                            
                        }
                        .padding(.vertical, 6)
                        .background(Divider(), alignment: .bottom)
                        .padding(.bottom, 4)
                        
                        HStack {
                            Image(systemName: "lock")
                            SecureField("Password", text: $viewModel.password)
                                .submitLabel(.go)
                        }
                        .padding(.vertical, 6)
                        .background(Divider(), alignment: .bottom)
                        .padding(.bottom, 8)
                        
                        Button (action: signInWithEmailPassword) {
                            if viewModel.authenticationState != .authenticating {
                                Text("Login")
                                    .bold()
                                    .foregroundStyle(Color.black)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 15)
                                    .background(Color.white)
                                    .cornerRadius(8)
                                    .shadow(color: colorScheme == .dark ? Color.white.opacity(0.2) : Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                            } else {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .black))
                                    .padding(.vertical, 8)
                                    .frame(maxWidth: .infinity)
                            }
                        }
                    }
                    .padding()
                    
                    HStack {
                        VStack { Divider() }
                        Text("or")
                        VStack { Divider() }
                    }
                    
                    VStack(spacing: 10){
                        
                        Button(action: signInWithGoogle){
                            HStack{
                                Image("google")
                                    .resizable()
                                    .frame(width: 20,height: 20)
                                Text("Sign in with Google")
                                    .bold()
                                    .foregroundStyle(Color.black)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 15)
                            .background(Color.white)
                            .cornerRadius(8)
                            .shadow(color: colorScheme == .dark ? Color.white.opacity(0.2) : Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                        }
                        
                        SignInWithAppleButton(.signIn) { request in
                            viewModel.handleSignInWithAppleRequest(request)
                        } onCompletion: { result in
                            viewModel.handleSignInWithAppleCompletion(result)
                        }
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .signInWithAppleButtonStyle(.white)
                        .shadow(color: colorScheme == .dark ? Color.white.opacity(0.2) : Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                        
                        Button{
                            isSignupView.toggle()
                        } label: {
                            HStack{
                                Image(systemName: "envelope.fill")
                                    .resizable()
                                    .frame(width: 25,height: 20)
                                    .foregroundStyle(Color.blue)
                                Text("Sign up with Email")
                                    .bold()
                                    .foregroundStyle(Color.black)
                                
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 15)
                            .background(Color.white)
                            .cornerRadius(8)
                            .shadow(color: colorScheme == .dark ? Color.white.opacity(0.2) : Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                        }
                    }
                    .padding()
                }
                .listStyle(.plain)
                .padding()
            }
            .sheet(isPresented: $isSignupView) {
                SignupView()
            }
        }
    }
}

#Preview {
    LoginView()
}
