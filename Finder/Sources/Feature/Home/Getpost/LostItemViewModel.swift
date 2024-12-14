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
    @Published var latestItems : [LatestPostModel] = []
    @Published var detailItems : DetailPostModel?
    @Published var id = 0

    //MARK: 글가져오기
    func fetchItems() {
        NetworkRunner.shared.request("/items/lost", method: .get, response: Status.self) { result in
            switch result {
            case .success(let data):
                self.items = data.data
                self.id = data.data.first?.id ?? 0
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: 최신순
    func getLatestItems() {
        NetworkRunner.shared.request("/items/lost/latest", method: .get, response: LatestStatus.self) { result in
            switch result {
            case .success(let data):
                self.latestItems = data.data
                self.id = data.data.first?.id ?? 0
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func detailPost() {
        let parameters = ["itemId" : id]
        NetworkRunner.shared.request("/items/\(id)", method: .get, parameters: parameters, response: DetailStatus.self) { result in
            switch result {
            case .success(let data):
                self.detailItems = data.data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
