import SwiftUI

struct LoginModel: Encodable {

    var email: String = ""
    var password: String = ""
    
    var loginparams: [String : Any] {
        return [
            "email" : email,
            "password": password
        ]
    }
}
