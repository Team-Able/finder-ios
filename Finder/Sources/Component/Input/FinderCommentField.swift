//
//  Finder.swift
//  Finder
//
//  Created by dgsw30 on 12/13/24.
//

import SwiftUI

struct FinderCommentField: View {
    let image: UIImage
    let text: String
    let action: () -> Void
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
                .tint(.primary500)
                .font(.custom("Pretendard-Regular", size: 14))
            
            Button {
                action()
            } label: {
                Text("게시")
                    .foregroundStyle(.primary600)
                    .font(.custom("Pretendard-Regular", size: 14))
                    .padding(.trailing)
            }
            
        }
        .background(Color.backgroundcolor)
        .frame(width: 344, height: 50)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(posttext.isEmpty ? Color.init(uiColor: .systemGray4) : Color.progress , lineWidth: 1)
        )
        .padding(.vertical, 2)
        .hideKeyBoard()
    }
}
