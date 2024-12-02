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
    @Published var items : [ItemInfo] = []
    let serverUrl = ServerUrl.shared
    func fetchItems() {
        let url = serverUrl.getUrl(for: "/items/lost")
        AF.request(url,method: .get, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Status.self) { response in
                switch response.result {
                case .success(let statusResponse):
                    DispatchQueue.main.async {
                        self.items = statusResponse.data
                    }
                    print("성공")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
