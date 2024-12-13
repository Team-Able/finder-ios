import Foundation

class MyViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var email: String = ""
    
    func fetchMy() {
        NetworkRunner.shared.request("/users/me", method: .get, response: UserData.self, isAuthorization: true) { result in
            switch result {
            case .success(let data):
                self.username = data.data.username
                self.email = data.data.email
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
