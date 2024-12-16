//
//  CommentViewModel.swift
//  Finder
//
//  Created by dgsw30 on 12/16/24.
//

import Foundation

class CommentViewModel: ObservableObject {
    @Published var comments: [Comment] = []
    
    func getComments(itemId: Int) {
        let id = [itemId : itemId]
        NetworkRunner.shared.request("/items/\(itemId)comment", method: .get, parameters: id, response: CommentSatatus.self, isAuthorization: true) { result in
            switch result {
            case .success(let data):
                self.comments = data.data.comments
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
