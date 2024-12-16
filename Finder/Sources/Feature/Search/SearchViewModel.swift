//
//  SearchViewModel.swift
//  Finder
//
//  Created by dgsw30 on 12/16/24.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var searchItem: [SearchModel] = []
    @Published var itemisEmpty = false
    
    func search(search: String) {
        let parameters = ["keyword": search]
        NetworkRunner.shared.request("/items/search", method: .get, parameters: parameters,response: SearchStatus.self, isAuthorization: true) { result in
            switch result {
            case .success(let data):
                self.searchItem = data.data
                self.itemisEmpty = self.searchItem.isEmpty
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
