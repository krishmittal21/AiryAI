//
//  TranslationAssistantView.swift
//  AiryAI
//
//  Created by Krish Mittal on 30/03/24.
//

import SwiftUI

struct TranslationAssistantView: View {
    @StateObject private var assistantViewModel = AssistantViewModel()
    @State private var translationText = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                HStack { VStack { Divider() } }
                Menu {
                    ForEach(Language.allLanguages) { language in
                        Button(action: {
                            assistantViewModel.translationLangugae = language.name
                        }) {
                            HStack {
                                Text(language.name + "(" + language.code + ") " + language.flag)
                            }
                        }
                    }
                } label: {
                    Text("Language: " + assistantViewModel.translationLangugae)
                    Spacer()
                    Image(systemName: "arrow.down")
                        .bold()
                }
                .foregroundStyle(.primary)
                .padding(.horizontal)
                HStack { VStack { Divider() } }
                TextField("Enter text to translate", text: $translationText, axis: .vertical)
                    .lineLimit(2...)
                    .font(.subheadline)
                    .textFieldStyle(.plain)
                    .padding()
                HStack { VStack { Divider() } }
                ScrollView {
                    Text(assistantViewModel.translationResult)
                }
            }
            .navigationTitle("Translation")
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
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        Task {
                            assistantViewModel.translationText = translationText
                            await assistantViewModel.translation()
                        }
                    }) {
                        Text("SUBMIT")
                            .foregroundStyle(.yellow)
                            .bold()
                    }
                }
            }
            
        }
    }
}

#Preview {
    TranslationAssistantView()
}
