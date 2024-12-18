//
//  CustomSecureField.swift
//  Finder
//
//  Created by dgsw30 on 10/2/24.
//

import SwiftUI

struct FinderSecureField: View {
    @State private var showPassword = false
    let image: UIImage
    let text: String
    @Binding var postText: String
    
    var body: some View {
        HStack {
            if image == .password {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 20, height: 25)
                    .padding(.leading, 12)
            } else {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(.leading, 12)
            }
            if showPassword == true {
                TextField(text, text: $postText)
                    .font(.system(size: 15))
                    .padding(.leading, 11)
                    .frame(height: 50)
                    .tint(.primary500)
                    .font(.custom("Pretendard-Regular", size: 14))
            } else {
                SecureField(text, text: $postText)
                    .font(.system(size: 15))
                    .padding(.leading, 11)
                    .frame(height: 50)
                    .tint(.primary500)
                    .font(.custom("Pretendard-Regular", size: 14))
            }
            
            Button {
                showPassword.toggle()
            } label: {
                Image(systemName: showPassword ? "eye.slash" : "eye")
                    .foregroundColor(.gray)
                    .padding(.trailing, 12)
            }
            .buttonStyle(PlainButtonStyle())

        }
        .background(Color.backgroundcolor)
        .frame(width: 300, height: 50)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(postText.isEmpty ? Color.init(uiColor: .systemGray4) : Color.primary500 , lineWidth: 1)
        )
        .padding(.vertical, 2)
    }
}
