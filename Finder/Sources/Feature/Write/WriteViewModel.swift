import Alamofire
import Foundation

class WriteViewModel: ObservableObject {
    @Published var item = ItemInfo(id: 0, title: "", content: "", imageUrl: "", location: ItemInfo.ItemLocation(latitude: 0, longitude: 0), createdAt: "", updatedAt: "")
    
    let serverUrl = ServerUrl.shared
    
    func postwrite() {
        print("postwrite 호출됨")
        let url = serverUrl.getUrl(for: "/items/lost")
        let params: [String:Any] = [
            "title": item.title,
            "content": item.content,
            "imageUrl": item.imageUrl,
            "location": [
                "latitude": item.location.latitude,
                "longitude": item.location.longitude
            ]
        ]
        
        guard let token = UserDefaults.standard.string(forKey: "accessToken") else {
            return
        }
        
        let _headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("서버 응답 데이터:", jsonString)
                    } else {
                        print("서버에서 빈 응답을 받았습니다.")
                    }
                case .failure(let error):
                    print("요청 실패 에러:", error)
                    if let statusCode = response.response?.statusCode {
                        print("HTTP 상태 코드:", statusCode)
                    }
                }
            }


        
    }
    func updateLocation(latitude: Double, longitude: Double) {
            item.location.latitude = latitude
            item.location.longitude = longitude
        }
}
//TODO: 검색, 홈, 글쓰기(post, 위치 검색해서 마크찍기)


