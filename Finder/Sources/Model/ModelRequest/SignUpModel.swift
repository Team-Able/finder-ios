import SwiftUI

struct SignUpModel: Encodable {
    
    var username: String = ""
    var email: String = ""
    var password: String = ""
    
    var signupparams: [String : Any]? {
        return [
            "username": username,
                "email": email,
                "password": password
        ]
    }
}
