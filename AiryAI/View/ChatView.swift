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
    
    var body: some View {
        VStack{
            Spacer()
            ScrollViewReader(content: { proxy in
                
            })
            .padding()
            Spacer()
            if selectedPhotoData.count > 0 {
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 10, content: {
                        ForEach(0..<selectedPhotoData.count, id: \.self) { count in
                            Image(uiImage: UIImage(data: selectedPhotoData[count])!)
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
                    Image(systemName: "mic").imageScale(.large)
                }
                Button{
                    
                } label: {
                    Image(systemName: "paperplane")
                }
            }
            .padding()
        }
    }
}

#Preview {
    ChatView()
}
