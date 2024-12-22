//
//  CommentModel.swift
//  Finder
//
//  Created by dgsw30 on 12/16/24.
//

import Foundation

//MARK: 댓글 받아오기
struct CommentStatus: Codable, StatusResponse {
    let data: [CommentModel]
}


struct CommentModel: Codable {
    let id: Int
    let content: String
    let author: CommentAuthor
    let children: [CommentModel]
    let createdAt: String
    let updatedAt: String
}

struct CommentAuthor: Codable {
    let id: String
    let username: String
    let profileImageUrl: String
}


//MARK: 댓글 썼을때
struct CommentResponse: Codable, StatusResponse {
    let data: CommentModel
}
