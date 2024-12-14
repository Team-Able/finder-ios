struct UserData: Codable {
    let data: UserDetail
    let status: Int
    let message: String
}

struct UserDetail: Codable {
    let email: String
    let username: String
}
