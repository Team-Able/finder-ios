import SwiftUI
import Alamofire

class LoginViewModel: ObservableObject {
    // 스크래치처럼 값을 방송해서 보냄
    @Published var email = ""
    @Published var password = ""
    @Published var loginerrorMessage: String?
    let serverUrl = ServerUrl.shared
    
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
        .responseDecodable(of: BaseResponse<TokenData>.self) { res in // 처리한거 변환
            switch res.result {
            case .success(let result):
                self.loginerrorMessage = nil
                UserDefaults.standard.set(result.data.accessToken, forKey: "accessToken")
                UserDefaults.standard.set(result.data.refreshToken, forKey: "refreshToken")
                print("성공")
            case .failure(let error):
                self.loginerrorMessage = "이메일과 비밀번호를 다시 입력해주세요."
                print("실패: \(error.localizedDescription)")
            }
        }
    }
    func checkEmail(str: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: str)
    }
}
