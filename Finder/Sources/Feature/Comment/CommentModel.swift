//
//  CommentModel.swift
//  Finder
//
//  Created by dgsw30 on 12/16/24.
//

import Foundation

struct CommentSatatus: Codable {
    let data: CommentData
    let status: Int
    let message: String
}

struct CommentData: Codable {
    let comments: [Comment]
}

struct Comment: Codable {
    let id: Int
    let content: String
    let author: CommentAuthor
    let children: [String]
    let createdAt: String
    let updatedAt: String
}

struct CommentAuthor: Codable {
    let id: String
    let username: String
}


