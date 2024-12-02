import Alamofire
import Foundation


class RefreshAccessToken {
    let serverUrl = ServerUrl.shared
    static let shared = RefreshAccessToken() 
    
    private init() {}
    
    func reissue(completion: @escaping () -> Void) {
        let url = serverUrl.getUrl(for: "/auth/ressue")
        
        guard let refreshToken = UserDefaults.standard.string(forKey: "refreshToken") else {
            print("Refresh token이 존재하지 않습니다.")
            return
        }
        
        let parameters: [String: Any] = [
            "refreshToken": refreshToken
        ]
        
        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default
        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: BaseResponse<TokenData>.self) { response in
            switch response.result {
            case .success(let result):
                UserDefaults.standard.set(result.data.accessToken, forKey: "accessToken")
                UserDefaults.standard.set(result.data.refreshToken, forKey: "refreshToken")
                completion()
            case .failure(let error):
                print("토큰 발급 실패: \(error.localizedDescription)")
                if let httpResponse = response.response {
                    print("응답 코드: \(httpResponse.statusCode)")
                    if let data = response.data, let errorMessage = String(data: data, encoding: .utf8) {
                        print("서버 응답: \(errorMessage)")
                    }
                }
            }
        }
    }
}
