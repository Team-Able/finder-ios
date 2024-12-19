//
//  CommentComponent.swift
//  Finder
//
//  Created by dgsw30 on 12/16/24.
//

import SwiftUI

struct CommentComponent: View {
    let comment: CommentModel
    let action: () -> Void
    @State private var detailComment = false
    
    var body: some View {
        VStack {
            HStack {
                AsyncImage(url: URL(string: comment.author.profileImageUrl)) { image in
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
                    Text(comment.author.username)
                        .font(.bold(16))
                        .padding(.bottom, 1)
                    Text(comment.content)
                        .font(.bold(14))
                        .padding(.bottom, 1)
                    Text(comment.createdAt)
                        .font(.regular(14))
                        .foregroundStyle(.graycolor)
                }
                Spacer()
            }
            
            HStack {
                Button {
                    detailComment.toggle()
                } label : {
                    HStack {
                        Image(systemName: detailComment ? "chevron.forward" : "chevron.down")
                        Text("답글")
                            .font(.regular(14))
                    }
                }
                .padding(.horizontal, 4)
                Button {
                    action()
                } label: {
                    Text("댓글달기")
                        .font(.regular(14))
                        .foregroundStyle(.black)
                }
                Spacer()
            }
            .padding(.leading, 24)
            
            if detailComment {
                ForEach(comment.children, id: \.id) { childComment in
                    SubCommentComponent(subComment: childComment)
                }
                .padding(.leading, 24)
            }
        }
    }
}
