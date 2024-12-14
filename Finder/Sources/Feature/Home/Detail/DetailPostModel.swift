import Foundation

// MARK: - DetailStatus
struct DetailStatus: Codable {
    let data: DetailPostModel
    let status: Int
    let message: String
}

// MARK: - DetailPostModel
struct DetailPostModel: Codable {
    let id: Int
    let title: String
    let author: DataAuthor
    let content: String
    let imageURL: String
    let status: String
    let location: DetailLocation
    let comments: [Comment]
    let createdAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, title, author, content, status, location, comments, createdAt, updatedAt
        case imageURL = "imageUrl"
    }
}

// MARK: - DataAuthor
struct DataAuthor: Codable {
    let id: String
    let profileImageURL: String? // Optional 처리
    let username: String
    let email: String
    let password: String
    let role: String

    enum CodingKeys: String, CodingKey {
        case id, username, email, password, role
        case profileImageURL = "profileImageURL"
    }
}

// MARK: - Comment
struct Comment: Codable {
    let id: Int
    let content: String
    let author: CommentAuthor
    let children: [String]
    let createdAt: String
    let updatedAt: String
}

// MARK: - CommentAuthor
struct CommentAuthor: Codable {
    let id: String
    let username: String
}

// MARK: - DetailLocation
struct DetailLocation: Codable {
    let latitude: Double
    let longitude: Double
}
