//
//  Tab.swift
//  Finder
//
//  Created by dgsw30 on 10/10/24.
//

import Foundation

enum TabViewType: CaseIterable {
    case search
    case home
    case write
    
    var image: String {
        switch self {
        case .search:
            return "search"
        case .home:
            return "home"
        case .write:
            return "write"
        }
    }
    
    var click: String {
        switch self {
        case .search:
            return "clicksearch"
        case .home:
            return "clickhome"
        case .write:
            return "clickwrite"
        }
    }
    
    var text: String {
        switch self {
        case .search:
            return "물건 찾기"
        case .home:
            return "홈"
        case .write:
            return "글쓰기"
        }
    }
}
