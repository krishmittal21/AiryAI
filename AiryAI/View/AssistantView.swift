//
//  AssistantView.swift
//  AiryAI
//
//  Created by Krish Mittal on 22/03/24.
//

import SwiftUI

struct AssistantView: View {
    @State private var showTranslationAssistant = false
    @State private var showEmailAssistant = false
    @State private var showPythonAssistant = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                HStack { VStack { Divider() } }
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        Text("Writing")
                            .bold()
                            .font(.title2)
                        Text("Enchance your wrting with tools for creation,\nediting, and style refinement.")
                            .font(.caption)
                    }
                    .padding()
                    AssistantTileView(title: "Email",
                                      subtitle: "Write and Respond to Emails",
                                    number: "1") {
                        showEmailAssistant.toggle()
                    }
                    AssistantTileView(title: "Translation",
                                      subtitle: "Translate text between languages",number: "2") {
                        showTranslationAssistant.toggle()
                    }
                }
                HStack { VStack { Divider() } }
//                VStack(alignment: .leading) {
//                    VStack(alignment: .leading) {
//                        Text("Programming")
//                            .bold()
//                            .font(.title2)
//                        Text("Write code, debug, test and learn.")
//                            .font(.caption)
//                    }
//                    .padding()
//                    AssistantTileView(title: "Python",
//                                      subtitle: "Debug Python Code",
//                                    number: "1") {
//                        showPythonAssistant.toggle()
//                    }
//                }
//                HStack { VStack { Divider() } }
            }
            .padding()
            .sheet(isPresented: $showTranslationAssistant, content: {
                TranslationAssistantView()
            })
            .sheet(isPresented: $showEmailAssistant, content: {
                EmailAssistantView()
            })
            .sheet(isPresented: $showPythonAssistant, content: {
                PythonAssistantView()
            })
        }
    }
}

#Preview {
    AssistantView()
}
