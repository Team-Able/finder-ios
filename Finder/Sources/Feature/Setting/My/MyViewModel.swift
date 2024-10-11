import Foundation
import Alamofire

class MyViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var email: String = ""
    let refreshToken = RefreshAccessToken.shared
    let serverUrl = ServerUrl.shared
    
    func fetchMy() {
        let url = serverUrl.getUrl(for: "/users/me")
        
        guard let token = UserDefaults.standard.string(forKey: "accessToken") else {
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   headers: headers
        )
        .validate()
        .responseJSON { response in
            switch response.result {
            case .success(let data):
                if let json = data as? [String : Any] {
                    print(json)
                    if let data = json["data"] as? [String: Any] {
                        if let email = data["email"] as? String,
                           let username = data["username"] as? String {
                            DispatchQueue.main.async {
                                self.email = email
                                self.username = username
                            }
                        }
                    }
                }
                print(data)
                print("업데이트된 email: \(self.email), username: \(self.username)")
            case .failure(let error):
                if let httpResponse = response.response, httpResponse.statusCode == 401 {
                    print("액세스 토큰 만료, 재발급 시도")
                    print(error)
                    self.refreshToken.reissue {
                        self.fetchMy()
                    }
                } else {
                    print("정보 조회 실패: \(error.localizedDescription)")
                }
            }
        }
    }
}
