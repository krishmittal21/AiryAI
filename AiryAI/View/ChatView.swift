//
//  ChatView.swift
//  AiryAI
//
//  Created by Krish Mittal on 22/03/24.
//

import SwiftUI
import PhotosUI
import AVFoundation

struct ChatView: View {
    @StateObject private var viewModel = ChatViewModel()
    @StateObject var speechRecognizer = SpeechRecognizer()
    @Environment(\.colorScheme) var colorScheme
    @State private var inputText: String = ""
    @State private var photoPickerItems = [PhotosPickerItem]()
    @State private var selectedPhotoData = [Data]()
    @State private var isRecording = false
    
    private func sendMessage() {
        Task {
            await viewModel.sendMessages(message: inputText.isEmpty ? speechRecognizer.transcript : inputText, imageData: selectedPhotoData)
            viewModel.saveMessages()
            selectedPhotoData.removeAll()
            inputText = ""
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            ScrollViewReader(content: { proxy in
                ConversationMessageView(conversation: viewModel.conversation)
                    .onChange(of: viewModel.conversation) {
                        guard let recentMessage = viewModel.conversation.last else {
                            return
                        }
                        DispatchQueue.main.async {
                            withAnimation {
                                proxy.scrollTo(recentMessage.id, anchor: .bottom)
                            }
                        }
                    }
            })
            if selectedPhotoData.count > 0 {
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 10, content: {
                        ForEach(0..<selectedPhotoData.count, id: \.self) { index in
                            Image(uiImage: UIImage(data: selectedPhotoData[index])!)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                        }
                    })
                }
                .frame(height: 50)
            }
            HStack {
                PhotosPicker(selection: $photoPickerItems, maxSelectionCount: 3, matching: .images) {
                    Image(systemName: "photo.stack")
                        .imageScale(.large)
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                }
                .onChange(of: photoPickerItems) {
                    Task {
                        selectedPhotoData.removeAll()
                        for item in photoPickerItems {
                            if let imageData = try await item.loadTransferable(type: Data.self) {
                                selectedPhotoData.append(imageData)
                            }
                        }
                    }
                }
                
                TextField("Message", text: $inputText, onCommit: sendMessage)
                    .textFieldStyle(RoundedRectTextFieldStyle())
                    .multilineTextAlignment(.leading)
                    .submitLabel(.go)
                
                Button(action: {
                    if isRecording {
                        speechRecognizer.stopTranscribing()
                        inputText = speechRecognizer.transcript
                    } else {
                        speechRecognizer.resetTranscript()
                        speechRecognizer.startTranscribing()
                    }
                    speechRecognizer.transcript = ""
                    isRecording.toggle()
                }) {
                    Image(systemName: isRecording ? "stop.fill" : "mic.fill")
                        .imageScale(.large)
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                }
                
                Button(action:sendMessage) {
                    Image(systemName: "paperplane.fill")
                        .imageScale(.large)
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                }
            }
            .padding()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    selectedPhotoData.removeAll()
                    speechRecognizer.transcript = ""
                    inputText = ""
                    viewModel.startNewChat()
                } label: {
                    Image(systemName: "square.and.pencil")
                        .imageScale(.large)
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                }
            }
        }
    }
}

struct RoundedRectTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.vertical, 5)
            .padding(.horizontal, 8)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.gray, lineWidth: 1)
            )
    }
}

#Preview {
    ChatView()
}
