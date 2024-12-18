//
//  CommentViiew.swift
//  Finder
//
//  Created by dgsw30 on 12/13/24.
//

import SwiftUI

struct CommentView: View {
    @StateObject private var commentVM = CommentViewModel()
    @State private var subComments = false
    @Binding var id: Int
    
    var body: some View {
        VStack {
            if subComments {
                FinderCommentField(image: .comment, text: "대댓글 작성하기", action: {
                    commentVM.writeComment(itemId: id, parentId: commentVM.parentId)
                }, posttext: $commentVM.content)
            } else {
                FinderCommentField(image: .comment, text: "댓글 작성하기", action: {
                    commentVM.writeComment(itemId: id, parentId: nil)
                }, posttext: $commentVM.content)
            }
            if commentVM.comments.isEmpty {
                ScrollView {
                    VStack {
                        Text("아직 댓글이 없습니다.")
                            .font(.medium(16))
                            .padding(.bottom, 4)
                        Text("말을 걸어 대화를 시작하세요.")
                            .font(.regular(12))
                    }
                }
                .refreshable {
                    commentVM.getComments(itemId: id)
                }
                .padding(.top, 50)
            } else {
                ScrollView {
                    ForEach(commentVM.comments, id: \.id) { comment in
                        CommentComponent(comment: comment) {
                            subComments.toggle()
                        }
                    }
                }
                .refreshable {
                    commentVM.getComments(itemId: id)
                }
            }
        }
        Spacer()
            .backButton()
            .onAppear {
                commentVM.getComments(itemId: id)
            }
            .finderAlert(isPresented: $commentVM.completePost, message: nil, text: "댓글이 게시되었어요")
    }
}
