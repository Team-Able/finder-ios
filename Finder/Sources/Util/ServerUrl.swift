import Foundation

struct ServerUrl {
    var baseUrl = "https://api.finder.mcv.kr"
    
    func getUrl(for endpoint: String) -> String {
        return baseUrl + endpoint
    }
    
    static let shared = ServerUrl()
    
    private init() {}
}
