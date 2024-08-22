import Foundation
import Alamofire

func postSignup(email: String, password: String, userName: String, completion: @escaping (Result<Void, Error>) -> Void) {
    let url = "http://finder.mcv.kr:8080/auth/signup"
    var request = URLRequest(url: URL(string: url)!)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let parameters: [String : Any] = [
        "email" : email,
        "password" : password,
        "username" : userName
    ]
    
    do {
        try request.httpBody = JSONSerialization.data(withJSONObject: parameters, options: [])
    } catch {
        completion(.failure(error))
        return
    }
    
    AF.request(request).response { response in
        switch response.result {
        case .success:
            if let httpResponse = response.response {
                if httpResponse.statusCode == 201 {
                    completion(.success(()))
                } else {
                    // 서버에서 반환된 오류 코드에 따라 처리
                    let error = NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "서버 오류: \(httpResponse.statusCode)"])
                    completion(.failure(error))
                }
            } else {
                
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "응답 없음"])
                completion(.failure(error))
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
}

func postlogin(email: String, password: String, completion : @escaping (Result<HTTPURLResponse, Error>) -> Void) {
    let url = "http://finder.mcv.kr:8080/auth/login"
    
    AF.request(url, method: .post, parameters: ["email": email, "password": password], encoding: JSONEncoding.default)
        .response { response in
            switch response.result {
            case .success:
                if let httpResponse = response.response {
                    if httpResponse.statusCode == 200 {
                        // 성공적인 응답 처리
                        completion(.success(httpResponse))
                    } else {
                        // 서버에서 반환된 오류 코드에 따라 처리
                        let error = NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "서버 오류: \(httpResponse.statusCode)"])
                        completion(.failure(error))
                    }
                } else {
                    // 응답이 없는 경우 처리
                    let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "응답 없음"])
                    completion(.failure(error))
                }
            case .failure(let error):
                // 네트워크 요청 실패 시 처리
                completion(.failure(error))
            }
        }
    
}

