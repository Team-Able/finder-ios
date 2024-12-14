//
//  WriteModel.swift
//  Finder
//
//  Created by dgsw30 on 12/2/24.
//

import Foundation

struct WriteModel: Codable {
    let title: String
    let content: String
    let imageUrl: String
    let location: Location
}

struct Location: Codable {
    let latitude: Double
    let longitude: Double
}


//MARK: 글쓰기 성공 했을떄
struct CompleteWrite {
    let data: DetailDataClass
    let status: Int
    let message: String
}

struct DetailDataClass {
    let id: Int
    let title: String
    let author: CompleteAuthor
    let content, imageURL, status: String
    let location: CompleteLocation
    let createdAt, updatedAt: String
}

struct CompleteAuthor {
    let id, username, email, password: String
    let role: String
}

struct CompleteLocation {
    let latitude, longitude: Int
}
