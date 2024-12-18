//
//  SearchViewModel.swift
//  Finder
//
//  Created by dgsw30 on 12/16/24.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var searchItem: [SearchModel] = []
    @Published var autoSearchItem: [String] = []
    @Published var itemisEmpty = false
    
    func search(search: String) {
        let parameters: [String: Any] = ["keyword": search]
        NetworkRunner.shared.request("/items/search", method: .get, parameters: parameters, response: SearchStatus.self, isAuthorization: true) { result in
            switch result {
            case .success(let data):
                self.searchItem = data.data
                self.itemisEmpty = self.searchItem.isEmpty
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func autoSearch(search: String) {
        let parameters: [String: Any] = ["prefix" : search]
        NetworkRunner.shared.request("/items/search/autocomplete", method: .get, parameters: parameters, response: AutoSearchStatus.self, isAuthorization: true) { result in
            switch result {
            case .success(let data):
                self.autoSearchItem = data.data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
