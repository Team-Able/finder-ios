//
//  LostItemViewModel.swift
//  Finder
//
//  Created by dgsw07 on 10/29/24.
//

import Foundation
import SwiftUI
import Alamofire

class LostItemViewModel: ObservableObject {
    @Published var items: [ItemInfo] = []
    @AppStorage("accessToken") private var token: String?
    let serverUrl = ServerUrl.shared
    let refresh = RefreshAccessToken.shared
    
    func fetchItems() {
        refresh.reissue {
            guard let token = self.token else {
                print("토큰유효하지않음")
                return
            }
        }
        
        let url = serverUrl.getUrl(for: "/items/lost")
        
        
        let _: HTTPHeaders = [
            "Authorization": "Bearer \(String(describing: token!))"
        ]
        print("Bearer \(String(describing: token!))")
        AF.request(url, method: .get, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Status.self) { response in
                switch response.result {
                case .success(let statusResponse):
                    DispatchQueue.main.async {
                        self.items = statusResponse.data
                    }
                    print("가져오기 성공")
                case .failure(let error):
                    print(error)
                    print("가져오기 실패: \(error.localizedDescription)")
                }
            }
    }
}
