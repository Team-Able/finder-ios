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

    //MARK: 글가져오기
    func fetchItems() {
        NetworkRunner.shared.request("/items/lost", method: .get, response: Status.self) { result in
            switch result {
            case .success(let data):
                self.items = data.data
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
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
