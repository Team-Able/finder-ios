//
//  TokenResponse.swift
//  Finder
//
//  Created by dgsw30 on 9/6/24.
//

import Foundation

struct TokenResponse: Decodable {
    let accessToken: String
    let refreshToken: String
}
