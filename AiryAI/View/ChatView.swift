//
//  ChatView.swift
//  AiryAI
//
//  Created by Krish Mittal on 22/03/24.
//

import SwiftUI
import PhotosUI

struct ChatView: View {
    @StateObject private var viewModel = ChatViewModel()
    @State private var userText: String = ""
    @State private var photoPickerItems = [PhotosPickerItem]()
    @State private var selectedPhotoData = [Data]()
    private func sendMessage() {
        Task {
            await viewModel.sendMessages(message: userText,imageData:selectedPhotoData)
            selectedPhotoData.removeAll()
            userText = ""
        }
    }
    var body: some View {
        VStack{
            Spacer()
            ScrollViewReader(content: { proxy in
                ScrollView {
                    ForEach(viewModel.messages) { chatMessage in
                        chatMessageView(chatMessage)
                    }
                }
                .onChange(of: viewModel.messages) {
                    guard let recentMessage = viewModel.messages.last else {
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
            HStack{
                Button{
                    
                } label: {
                    Image(systemName: "camera").imageScale(.large)
                }
                PhotosPicker(selection: $photoPickerItems, maxSelectionCount: 3, matching: .images) {
                    Image(systemName: "photo.stack").imageScale(.large)
                }
                .onChange(of: photoPickerItems) {
                    Task {
                        selectedPhotoData.removeAll()
                        for item in photoPickerItems {
                            if let imageData = try await item.loadTransferable(type: Data.self){
                                selectedPhotoData.append(imageData)
                            }
                        }
                    }
                }
                TextField("Talk with AiryAI", text: $userText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                Button{
                    
                } label: {
                    Image(systemName: "mic").imageScale(.medium)
                }
                .buttonStyle(.bordered)
                Button(action:sendMessage) {
                    Image(systemName: "paperplane.fill")
                }
            }
            .padding()
        }
    }
    @ViewBuilder
    private func chatMessageView(_ message: ChatMessage) -> some View {
        if let images = message.images, images.isEmpty == false {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 10 ,content: {
                    ForEach(0..<images.count, id: \.self) { index in
                        Image(uiImage: UIImage(data: images[index])!)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .containerRelativeFrame(.horizontal)
                    }
                })
                .scrollTargetLayout()
            }
            .frame(width: 100, height: 100)
        }
        ChatBubbleView(direction: message.role == .model ? .left : .right) {
            Text(message.message)
                .font(.caption)
                .padding(15)
                .background(message.role == .model ? Color.customBlue : Color.backgroundColor)
        }
    }
}

#Preview {
    ChatView()
}
