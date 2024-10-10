struct TokenResponse: Codable {
    let data: TokenData
    let status: Int
    let message: String
}

struct TokenData: Codable {
    let accessToken: String
    let refreshToken: String
}

