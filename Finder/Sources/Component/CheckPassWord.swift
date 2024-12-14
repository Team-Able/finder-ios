//
//  CheckPassWord.swift
//  Finder
//
//  Created by dgsw30 on 10/9/24.
//

import SwiftUI

struct CheckPassWord: View {
    let text: String
    let check: Bool
    @Binding var postText: String
    var body: some View {
        HStack {
            Image(.password)
                    .resizable()
                    .frame(width: 20, height: 25)
                    .padding(.leading, 12)
            
            SecureField(text, text: $postText)
                .font(.system(size: 15))
                .padding(.leading, 11)
                .frame(height: 50)
                .tint(.primary500)
                .font(.custom("Pretendard-Regular", size: 14))
            
            if check == true {
                Image(.checkmark)
                    .resizable()
                    .frame(width: 16,height: 18)
                    .padding(.trailing, 14)
            }
            
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
