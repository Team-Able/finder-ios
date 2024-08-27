import SwiftUI

struct SignUpRequest: Encodable {
    
    var username: String = ""
    var email: String = ""
    var password: String = ""
    var checkpassword: String = ""
    
    var signupparams: [String: Any] {
        return ["username": username,
                "email": email,
                "password": password]
    }
}



