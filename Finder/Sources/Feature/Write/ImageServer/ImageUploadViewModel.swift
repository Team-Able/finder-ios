import Alamofire
import UIKit
import Foundation

class ImageUploadViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var imageUrl: String?
    let refreshToken = RefreshAccessToken.shared
    let serverUrl = ServerUrl.shared
    
    func uploadImage() {
        let url = serverUrl.getUrl(for: "/files/upload")
        
        guard let image = image else {
            print("이미지가 없습니다.")
            return
        }
        
        guard let imageData = image.jpegData(compressionQuality: 0.2) else {
            print("이미지 데이터를 변환하는 데 실패했습니다.")
            return
        }
        
        guard let token = UserDefaults.standard.string(forKey: "accessToken") else {
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")
        }, to: url, method: .post, headers: headers)
        .responseData { response in
            switch response.result {
            case .success(let data):
                if let responseString = String(data: data, encoding: .utf8) {
                    print("서버 응답: \(responseString)")
                }
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let imageName = json["data"] as? String {  // "data" 키를 사용하여 이미지 이름을 가져옴
                        DispatchQueue.main.async {
                            // url/uploads/imageName
                            self.imageUrl = self.serverUrl.baseUrl + "/uploads/" + imageName
                            print(self.imageUrl)
                        }
                    } else {
                        print("응답 데이터에서 이미지 URL을 찾을 수 없습니다.")
                    }
                } catch {
                    print("JSON 파싱 오류: \(error.localizedDescription)")
                }
            case .failure(let error):
                print("이미지 업로드 실패: \(error.localizedDescription)")
            }
        }
    }
}
