//
//  ProfileImage.swift
//  Senario
//
//  Created by dgsw07 on 3/5/25.
//

import SwiftUI

struct ProfileImage: View {
    @State var showImagePicker = false
    @State var selectedUIImage: UIImage?
    @State var image: Image?
    
    func loadImage() {
        guard let selectedImage = selectedUIImage else { return }
        image = Image(uiImage: selectedImage)
    }
    var body: some View {
        VStack {
            if let image = image {
                image
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 120, height: 120)
            } else {
                Button {
                    showImagePicker.toggle()
                } label: {
                    Circle()
                        .frame(width: 128,height: 128)
                        .foregroundColor(Color(hex: "F3F4F5"))
                        .overlay {
                            Circle()
                                .stroke(lineWidth: 1.0)
                                .foregroundColor(.black.opacity(0.1))
                                .overlay {
                                    Image(systemName: "plus")
                                        .font(.system(size: 36))
                                        .foregroundColor(.black.opacity(0.5))
                                }
                        }
                }
            }
        }
        .sheet(isPresented: $showImagePicker, onDismiss: {
                       loadImage()
                   }) {
                       ImagePicker(image: $selectedUIImage)
               }
    }
}

#Preview {
    ProfileImage()
}
