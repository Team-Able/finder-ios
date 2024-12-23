//
//  LostItemModel.swift
//  Finder
//
//  Created by dgsw07 on 10/29/24.
//

import Foundation
import SwiftUI

struct ItemInfo: Codable {
    var id: Int
    var title: String
    var content: String
    var imageUrl: String
    var status: String?
    var location: ItemLocation
    var createdAt: String
    var updatedAt: String
    
    struct ItemLocation: Codable {
        var latitude: Double
        var longitude: Double
    }
}

struct Status: Codable, StatusResponse {
    var data: [ItemInfo]
}

