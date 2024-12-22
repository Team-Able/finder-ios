//
//  CommentViewModel.swift
//  Finder
//
//  Created by dgsw30 on 12/16/24.
//

import Foundation

class CommentViewModel: ObservableObject {
    @Published var comments: [CommentModel] = []
    @Published var content = ""
    @Published var parentId: Int? = 0
    @Published var completePost = false
    
    func writeComment(itemId: Int, parentId: Int?) {
        let parameters: [String : Any] = [
            "itemId": itemId,
            "content" : content,
            "parentId" : parentId ?? NSNull()
        ]
        NetworkRunner.shared.request("/items/comments", method: .post, parameters: parameters, response: CommentResponse.self, isAuthorization: true) { result in
            switch result {
            case .success(_):
                self.completePost = true
                self.content = ""
                self.getComments(itemId: itemId)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func getComments(itemId: Int) {
        let id: [String : Any] = ["itemId" : itemId]
        NetworkRunner.shared.request("/items/\(itemId)/comment", method: .get, parameters: id, response: CommentStatus.self, isAuthorization: true) { result in
            switch result {
            case .success(let data):
                self.comments = data.data
                self.parentId = data.data.first?.id
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
