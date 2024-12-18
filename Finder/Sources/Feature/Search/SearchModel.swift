//
//  LatestPostModel.swift
//  Finder
//
//  Created by dgsw30 on 12/14/24.
//

import Foundation
import SwiftUI

struct SearchModel: Identifiable, Codable {
    var id: Int
    var title: String
    var content: String
    var imageUrl: String
    var status: String?
    var location: SearchItemLocation
    var createdAt: String
    var updatedAt: String
    
    struct SearchItemLocation: Codable {
        var latitude: Double
        var longitude: Double
    }
}

struct SearchStatus: Codable, StatusResponse {
    var data: [SearchModel]
}

