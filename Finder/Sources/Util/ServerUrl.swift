import Foundation

struct ServerUrl {
    var baseUrl = "http://15.165.119.40:8080"
    
    func getUrl(for endpoint: String) -> String {
        return baseUrl + endpoint
    }
    
    static let shared = ServerUrl()
    
    private init() {}
}
