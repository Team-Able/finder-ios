//
//  GetPostModel.swift
//  Finder
//
//  Created by dgsw07 on 11/1/24.
//

import Foundation

struct getPostModel: Decodable {
    var title: String
    var content: String
    var iamgeurl: String
    var location: Location
}

struct Location {
    var latitude: Double
    var longitude: Double
}
