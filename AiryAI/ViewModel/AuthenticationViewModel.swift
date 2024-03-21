//
//  AuthenticationViewModel.swift
//  AiryAI
//
//  Created by Krish Mittal on 21/03/24.
//

import Foundation

enum AuthenticationState {
    case unauthenticated
    case authenticating
    case authenticated
}

class AuthenticationViewModel: ObservableObject{
    
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var authenticationState: AuthenticationState = .unauthenticated
}
