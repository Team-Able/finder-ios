import SwiftUI
import Alamofire

class SignUpViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var checkpassword: String? = nil
    @Published var signuperrorMessage: String? = nil
    let serverUrl = ServerUrl.shared
    
    var isSignupDisabled: Bool {
        email.isEmpty || password.isEmpty || username.isEmpty ||
        password.count < 8 || password.count > 32 ||
        username.count < 3 || username.count > 20 ||
        !checkEmail(str: email)
    }
    
    func signUp() {
        let url = serverUrl.getUrl(for: "/auth/signup")
        
        AF.request(
            url,
            method: .post,
            parameters: SignUpModel(
                username: username,
                email: email,
                password: password
            ),
            encoder: JSONParameterEncoder.default
        )
        .validate(statusCode: 200..<300)
        .response { response in
            switch response.result {
            case .success(let _result):
                print("성공")
                self.signuperrorMessage = nil
            case .failure(let error):
                print(error)
                self.signuperrorMessage = "예상치 못한 오류가 발생했습니다."
            }
        }
    }
    
    func checkEmail(str: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: str)
    }
}
