import Alamofire
import Foundation

struct LostItem: Codable {
    var title: String
    var content: String
    var imageUrl: String
    var location: Location
    
    struct Location: Codable {
        var latitude: Double
        var longitude: Double
    }
}

struct ResponseData: Codable {
    var data: DataInfo
    var status: Int
    var message: String
    
    struct DataInfo: Codable {
        var id: Int
        var title: String
        var content: String
        var imageUrl: String
        var status: String
        var location: Location
        var createdAt: String
        var updatedAt: String
        
        struct Location: Codable {
            var latitude: Double
            var longitude: Double
        }
    }
}
