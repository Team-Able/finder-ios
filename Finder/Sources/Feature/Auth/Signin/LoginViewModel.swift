import SwiftUI
import Alamofire

class LoginViewModel: ObservableObject {
    // 스크래치처럼 값을 방송해서 보냄
    @Published var email = ""
    @Published var password = ""
    @Published var loginerrorMessage: String? = nil
    @Published var islogin = false
    
    
    var isLoginDisabled: Bool {
        email.isEmpty || password.isEmpty
    }
    
    func login() {
        let url = "http://finder.mcv.kr:8080/auth/login"
        
        AF.request(
            url,
            method: .post,
            parameters: LoginModel(
                email: email,
                password: password
            ),
            encoder: JSONParameterEncoder()
        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: TokenResponse.self) { res in
            switch res.result {
            case .success(let result):
                // 저장
                self.loginerrorMessage = nil
                UserDefaults.standard.setValue(result.accessToken, forKey: "accessToken")
                UserDefaults.standard.setValue(result.refreshToken, forKey: "refreshToken")
                print(res)
            case .failure(let error):
                print("실패")
                self.loginerrorMessage = "예상치 못한 오류가 발생했습니다."
            }
        }
    }
}
