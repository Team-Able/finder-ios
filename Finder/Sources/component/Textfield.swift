//
//  Textfield.swift
//  Finder
//
//  Created by dgsw30 on 9/6/24.
//

import SwiftUI

struct Textfield: View {
    let image: UIImage
    let text: String
    @Binding var posttext: String
    
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
            
            TextField(text, text: $posttext)
                .font(.system(size: 15))
                .padding(.leading, 11)
                .frame(height: 50)
                .tint(.maincolor)
                .font(.custom("Pretendard-Regular", size: 14))
        }
        .background(Color.backgroundcolor)
        .frame(width: 300, height: 50)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(posttext.isEmpty ? Color.init(uiColor: .systemGray4) : Color.textfield , lineWidth: 1)
        )
        .padding(.vertical, 2)
    }
}
