//
//  CommentViiew.swift
//  Finder
//
//  Created by dgsw30 on 12/13/24.
//

import SwiftUI

struct CommentView: View {
    @Binding var id: Int
    @State private var comment = ""
    @StateObject private var commentVM = CommentViewModel()
    var body: some View {
        VStack {
            FinderCommentField(image: .comment, text: "댓글 작성하기", action: {
                
            }, posttext: $comment)
            if commentVM.comments.isEmpty {
                VStack {
                    Text("아직 댓글이 없습니다.")
                        .font(.medium(16))
                        .padding(.bottom, 4)
                    Text("말을 걸어 대화를 시작하세요.")
                        .font(.regular(12))
                }
                .padding(.top, 50)
            } else {
                ForEach(commentVM.comments, id: \.id) { comment in
                    CommentComponent(comment: comment)
                }
            }
        }
        Spacer()
            .backButton()
            .onAppear {
                commentVM.getComments(itemId: id)
            }
    }
}
