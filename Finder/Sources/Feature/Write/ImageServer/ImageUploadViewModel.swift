import UIKit
import Foundation

class ImageUploadViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var imageUrl: String?
    
    func getImageUrl(completion: @escaping (String?) -> Void) {
        guard let image else {
            print("이미지가 없습니다.")
            completion(nil)
            return
        }
        
        guard let imageData = image.jpegData(compressionQuality: 0.1) else {
            print("이미지 데이터를 변환하는 데 실패했습니다.")
            completion(nil)
            return
        }
        
        NetworkRunner.shared.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(imageData, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")
            },
            to: "/files/upload",
            response: ImageResponse.self,
            isAuthorization: true
        ) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.imageUrl = ("\(baseUrl)/" + data.data)
                    completion("\(baseUrl)/" + data.data)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print("이미지 업로드 실패: \(error.localizedDescription)")
                    completion(nil)
                }
            }
        }
    }
}


struct ImageResponse: Decodable {
    let data: String
    let status: Int
    let message: String
}
