//
//  SubCommentComponent.swift
//  Finder
//
//  Created by dgsw30 on 12/18/24.
//

import SwiftUI

struct SubCommentComponent: View {
    let subComment: CommentModel
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: subComment.author.profileImageUrl)) { image in
                image
                    .resizable()
                    .frame(width: 57, height: 57)
            } placeholder: {
                Rectangle()
                    .frame(width: 57, height: 57)
            }
            .clipShape(RoundedRectangle(cornerRadius: 100))
            .padding()
            VStack(alignment: .leading, spacing: 2) {
                Text(subComment.author.username)
                    .font(.bold(16))
                    .padding(.bottom, 1)
                Text(subComment.content)
                    .font(.bold(14))
                    .padding(.bottom, 1)
                Text(subComment.createdAt)
                    .font(.regular(14))
                    .foregroundStyle(.graycolor)
            }
            Spacer()
        }
    }
}
