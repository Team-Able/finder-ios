import SwiftUI
import Alamofire

class LoginViewModel: ObservableObject {
    // 스크래치처럼 값을 방송해서 보냄
    @Published var email = ""
    @Published var password = ""
    @Published var loginerrorMessage: String? = nil
    @Published var islogin = false
    let serverUrl = ServerUrl()
    
    init() {
        checkIfLoggedIn()
    }
    
    var isLoginDisabled: Bool {
        email.isEmpty || password.isEmpty ||
        password.count < 8 || password.count > 32 ||
        !checkEmail(str: email)
    }
    
    func login() {
        let url = serverUrl.getUrl(for: "/auth/login")
        
        AF.request(
            url,
            method: .post,
            parameters: LoginModel(
                email: email,
                password: password
            ),
            encoder: JSONParameterEncoder.default
        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: TokenResponse.self) { res in
            switch res.result {
            case .success(let result):
                self.loginerrorMessage = nil
                func accesstoken() {
                    UserDefaults.standard.setValue(result.accessToken, forKey: "accessToken")
                }
                func refreshtoken() {
                    UserDefaults.standard.setValue(result.refreshToken, forKey: "refreshToken")
                }
                print(res)
                self.islogin = true
            case .failure(let error):
                print("실패")
                self.loginerrorMessage = "예상치 못한 오류가 발생했습니다."
            }
        }
    }
    func checkEmail(str: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return  NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: str)
    }
    
    func checkIfLoggedIn() {
        if let save = UserDefaults.standard.string(forKey: "accessToken") {
            self.islogin = true
        } else {
            self.islogin = false
        }
    }
}
