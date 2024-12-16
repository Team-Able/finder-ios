struct UserData: Codable {
    let data: UserDetail
    let status: Int
    let message: String
}

struct UserDetail: Codable {
    let email: String
    let username: String
}

struct UserDelete: Codable {
    let data: EmptyData
    let status: Int
    let message: String
}

struct EmptyData: Codable {}
