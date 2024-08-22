import Foundation
import Alamofire

func postSignup(email: String, password: String, userName: String, completion: @escaping (Result<Void, Error>) -> Void) {
    let url = "http://finder.mcv.kr:8080/auth/signup"
    
    let parameters: [String : Any] = [
        "email" : email,
        "password" : password,
        "username" : userName
    ]
    
    
    AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
        .validate(statusCode: 200..<300)
        .responseData { response in
            print("REsponse")
            print(response)
        
        }
        .responseData { response in
            switch response.result {
            case .success(let value):
                if let json = value as? [String: Any] {
                    print("Signup Success: \(json)")

                    if let success = json["success"] as? Bool, success {
                        completion(.success(()))
                    } else {
                        let errorMessage = json["message"] as? String ?? "Signup failed due to unknown reason."
                        let error = NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                        completion(.failure(error))
                    }
                } else {

                    let error = NSError(domain: "", code: 2, userInfo: [NSLocalizedDescriptionKey: "Invalid response format"])
                    completion(.failure(error))
                }
            case .failure(let error):
                print("Request failed with error: \(error)")
                completion(.failure(error))
            }
        }
}


