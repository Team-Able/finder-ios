import SwiftUI

struct LoginRequest: Encodable {

    var email: String = ""
    var password: String = ""
    
    var loginparams: [String : Any] {
        return [
            "email" : email,
            "password": password
        ]
    }
}
