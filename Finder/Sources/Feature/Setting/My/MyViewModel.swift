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
}
