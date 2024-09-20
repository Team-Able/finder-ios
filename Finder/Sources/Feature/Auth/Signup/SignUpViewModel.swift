import SwiftUI
import Alamofire

class SignUpViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var checkpassword: String? = nil
    @Published var signuperrorMessage: String? = nil
    
    var isSignupDisabled: Bool {
        email.isEmpty || password.isEmpty || password.isEmpty || username.isEmpty
    }
    
    func signUp() {
        let url = "http://finder.mcv.kr:8080/auth/signup"
        
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
            case .success(let result):
                print("성공")
                self.signuperrorMessage = nil
            case .failure(let error):
                print("실패")
                self.signuperrorMessage = "예상치 못한 오류가 발생했습니다."
            }
        }
    }
}
