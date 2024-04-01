//
//  SplashScreenView.swift
//  AiryAI
//
//  Created by Krish Mittal on 01/04/24.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State var isActive: Bool = false
    
    var body: some View {
        ZStack{
            if self.isActive {
                MainView()
            } else {
                Color.backgroundColor.edgesIgnoringSafeArea(.all)
                Image("logo-transparent")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
