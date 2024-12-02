//
//  SottOrder.swift
//  Finder
//
//  Created by dgsw07 on 10/30/24.
//

import Foundation

struct SortOrder: Identifiable {
    let id = UUID()
    let sorted: String
}

extension SortOrder {
    static let list: [SortOrder] = [
        SortOrder(sorted: "가까운 순"),
        SortOrder(sorted: "인기순"),
        SortOrder(sorted: "최신순")
    ]
}
