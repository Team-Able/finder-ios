struct UserData: Codable, StatusResponse {
    let data: UserDetail
}

struct UserDetail: Codable {
    let profileImageUrl: String
    let email: String
    let username: String
}

struct UserDelete: Codable, StatusResponse {
    let data: EmptyData
}

struct EmptyData: Codable {}
