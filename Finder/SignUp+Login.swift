//import Foundation
//import Alamofire
//
//func postSignup(email: String, password: String, userName: String, completion: @escaping (Result<Void, Error>) -> Void) {
//    let url = "http://finder.mcv.kr:8080/auth/signup"
//    
//    let parameters: [String: Any] = [
//        "email": email,
//        "password": password,
//        "username": userName
//    ]
//    
//    AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
//        .validate(statusCode: 201..<202)
//        .response { response in
//            switch response.result {
//            case .success(let value):
//                print("성공")
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//}
//
//func postlogin(email: String, password: String, completion: @escaping (Result<HTTPURLResponse, Error>) -> Void) {
//    let url = "http://finder.mcv.kr:8080/auth/login"
//    
//    AF.request(url, method: .post, parameters: ["email": email, "password": password], encoding: JSONEncoding.default)
//        .response { response in
//            switch response.result {
//            case .success:
//                if let httpResponse = response.response {
//                    if httpResponse.statusCode == 201 {
//
//                        completion(.success(httpResponse))
//                    } else {
//                        // 서버에서 반환된 오류 코드에 따라 처리
//                        let error = NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "서버 오류: \(httpResponse.statusCode)"])
//                        completion(.failure(error))
//                    }
//                } else {
//                    // 응답이 없는 경우 처리
//                    let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "응답 없음"])
//                    completion(.failure(error))
//                }
//            case .failure(let error):
//                // 네트워크 요청 실패 시 처리
//                completion(.failure(error))
//            }
//        }
//    
//}
//
