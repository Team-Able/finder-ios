//
//  CommentComponent.swift
//  Finder
//
//  Created by dgsw30 on 12/16/24.
//

import SwiftUI

struct CommentComponent: View {
    let comment: Comment
    @State private var detailComment = false
    
    var body: some View {
        ScrollView {
            HStack {
                Image(.myimage)
                    .resizable()
                    .frame(width: 57, height: 57)
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
                        Image(systemName: "chevron.down")
                        Text("답글 4")
                    }
                    Spacer()
                }
            }
            .padding(.leading, 24)
            
            if detailComment {
                Text("디테링ㄹ")
            }
        }
    }
}
