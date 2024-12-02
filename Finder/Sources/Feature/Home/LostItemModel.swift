//
//  LostItemModel.swift
//  Finder
//
//  Created by dgsw07 on 10/29/24.
//

import Foundation
import Alamofire
import SwiftUI

struct ItemInfo: Identifiable,Codable {
    var id: Int
    var title: String
    var content: String
    var imageUrl: String
    var status: String?
    var location: ItemLocation
    var createdAt: String
    var updatedAt: String
    
    init(id: Int, title: String, content: String, imageUrl: String, status: String? = nil, location: ItemLocation, createdAt: String, updatedAt: String) {
        self.id = id
        self.title = title
        self.content = content
        self.imageUrl = imageUrl
        self.status = status
        self.location = location
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    struct ItemLocation: Codable {
        var latitude: Double
        var longitude: Double
    }
}



struct Status: Codable {
    var data: [ItemInfo]
    var status: Int
    var message: String
}

