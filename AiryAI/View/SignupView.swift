//
//  SigninView.swift
//  AiryAI
//
//  Created by Krish Mittal on 21/03/24.
//

import SwiftUI
import AuthenticationServices

struct SignupView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject var viewModel = Authentication()
    @State var showTerms:Bool = false
    
    private func signUpWithEmailPassword() {
        Task {
            await viewModel.signUpWithEmailPassword()
        }
    }
    
    var body: some View {
        
        VStack(spacing:10){
            
            VStack(alignment: .leading, spacing: 8) {
                
                Text("Complete Your Profile")
                    .font(.system(size: 25, weight: .medium, design: .rounded))
                Text("Don't worry only you can see your personal info, no one else will be able to see it")
                    .font(.system(size: 15))
            }
            .padding(.top, 20)
            .padding()
            
            VStack{
                
                HStack {
                    Image(systemName: "person")
                    TextField("Name", text: $viewModel.name)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .submitLabel(.next)
                    
                }
                .padding(.vertical, 6)
                .background(Divider(), alignment: .bottom)
                .padding(.bottom, 4)
                
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
                
                HStack {
                    Image(systemName: "lock")
                    SecureField("Confirm Password", text: $viewModel.confirmPassword)
                        .submitLabel(.go)
                }
                .padding(.vertical, 6)
                .background(Divider(), alignment: .bottom)
                .padding(.bottom, 8)
            }
            .padding()
            
            Button (action: signUpWithEmailPassword) {
                if viewModel.authenticationState != .authenticating {
                    Text("Sign up")
                        .bold()
                        .foregroundStyle(Color.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(color: colorScheme == .dark ? Color.white.opacity(0.2) : Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                } else {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity)
                }
                
            }
            .padding(.horizontal)
            
            VStack(spacing: 4) {
                Text("By Signing Up, you agree to our ")
                +
                Text("Terms & Conditions")
                    .foregroundColor(Color.primaryColor)
            }
            .font(.caption)
            .onTapGesture {
                showTerms = true
            }
        }
        .sheet(isPresented: $showTerms, content: {
            TermsofUseView()
        })
    }
}

#Preview {
    SignupView()
}
