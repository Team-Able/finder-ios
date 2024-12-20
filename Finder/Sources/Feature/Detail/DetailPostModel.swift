import Foundation

// MARK: - DetailStatus
struct DetailStatus: Codable, StatusResponse {
    let data: DetailPostModel
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
}

// MARK: - DetailLocation
struct DetailLocation: Codable {
    let latitude: Double
    let longitude: Double
}
