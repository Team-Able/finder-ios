//
//  CommentViiew.swift
//  Finder
//
//  Created by dgsw30 on 12/13/24.
//

import SwiftUI

struct CommentView: View {
    @State private var comment = ""
    var body: some View {
        VStack {
            FinderCommentField(image: .comment, text: "댓글 작성하기", action: {
                
            }, posttext: $comment)
        }
    }
}

#Preview {
    CommentView()
}
