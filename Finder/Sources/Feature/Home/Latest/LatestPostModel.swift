//
//  LatestPostModel.swift
//  Finder
//
//  Created by dgsw30 on 12/14/24.
//

import Foundation
import SwiftUI

struct LatestPostModel: Identifiable,Codable {
    var id: Int
    var title: String
    var content: String
    var imageUrl: String
    var status: String?
    var location: LatestItemLocation
    var createdAt: String
    var updatedAt: String
    
    struct LatestItemLocation: Codable {
        var latitude: Double
        var longitude: Double
    }
}

struct LatestStatus: Codable, StatusResponse {
    var data: [LatestPostModel]
}


