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
}
