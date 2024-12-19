import Foundation

class MyViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var profileImageUrl: String = ""
    @Published var patchComplete: Bool = false
    
    func fetchMy() {
        NetworkRunner.shared.request("/users/me", method: .get, response: UserData.self, isAuthorization: true) { result in
            switch result {
            case .success(let data):
                self.username = data.data.username
                self.email = data.data.email
                self.profileImageUrl = data.data.profileImageUrl
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteMy() {
        NetworkRunner.shared.request("/users/secession", method: .delete, response: UserDelete.self, isAuthorization: true) { result in
            switch result {
            case .success(_):
                UserDefaults.standard.removeObject(forKey: "accessToken")
                UserDefaults.standard.removeObject(forKey: "refreshToken")
            case .failure(let error):
                print(error.localizedDescription)
                print("실패")
            }
        }
    }
    
    func patchMy(imageUrl: String, userName: String) {
        let parameters : [String : Any] = [
            "profileImageURL" : imageUrl,
            "username" : userName
        ]
        NetworkRunner.shared.request("/users/me", method: .patch, parameters: parameters, response: MyModelStatus.self) { result in
            switch result {
            case .success(_):
                self.patchComplete = true
                self.fetchMy()
            case .failure(_):
                print("실패")
            }
        }
    }
    
    func patchMyImage(imageUrl: String) {
        let parameters : [String : Any] = [
            "profileImageURL" : imageUrl,
        ]
        NetworkRunner.shared.request("/users/me", method: .patch, parameters: parameters, response: MyModelStatus.self) { result in
            switch result {
            case .success(_):
                self.patchComplete = true
                self.fetchMy()
            case .failure(_):
                print("실패")
            }
        }
    }
    
    func patchMyName(userName: String) {
        let parameters : [String : Any] = [
            "username" : userName
        ]
        NetworkRunner.shared.request("/users/me", method: .patch, parameters: parameters, response: MyModelStatus.self) { result in
            switch result {
            case .success(_):
                self.patchComplete = true
                self.fetchMy()
            case .failure(_):
                print("실패")
            }
        }
    }
}
