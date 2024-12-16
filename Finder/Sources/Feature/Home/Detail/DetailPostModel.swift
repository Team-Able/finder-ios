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
    let content: String
    let imageUrl: String
    let status: String
    let location: DetailLocation
    let createdAt: String
    let updatedAt: String
    let author: Author
}

// MARK: - Author
struct Author: Codable {
    let id: String
    let profileImageURL: String?
    let username: String
    let email: String
    let password: String
    let role: String
}

// MARK: - DetailLocation
struct DetailLocation: Codable {
    let latitude: Double
    let longitude: Double
}
