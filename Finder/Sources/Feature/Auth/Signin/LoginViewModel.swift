import SwiftUI
import Alamofire

class LoginViewModel: ObservableObject {
    // 스크래치처럼 값을 방송해서 보냄
    @Published var request: LoginRequest = .init()
    @Published var loginerrorMessage: String? = nil
    
    var isLoginDisabled: Bool {
        request.email.isEmpty || request.password.isEmpty
    }
    
    func login() {
        let url = "http://finder.mcv.kr:8080/auth/login"
        
        AF.request(url,
                   method: .post,
                   parameters: request.loginparams,
                   encoding: JSONEncoding.default)
        .validate(statusCode: 200..<300)
        .response { response in
            switch response.result {
            case .success(let result):
                print("성공")
                self.loginerrorMessage = nil
            case .failure(let error):
                print("실패")
                self.loginerrorMessage = "예상치 못한 오류가 발생했습니다."
            }
        }
    }
}
