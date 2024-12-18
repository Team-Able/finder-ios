//
//  DetailViewModel.swift
//  Finder
//
//  Created by dgsw30 on 12/17/24.
//

import Foundation

class DetailViewModel: ObservableObject {
    @Published var detailItems : DetailPostModel?
    
    func detailPost(id: Int) {
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
