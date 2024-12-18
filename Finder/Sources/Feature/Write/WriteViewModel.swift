import Foundation

class WriteViewModel: ObservableObject {
    @Published var successAlert = false
    @Published var title = ""
    @Published var content = ""
    @Published var image: String? = ""
    @Published var latitude = 37.74913611
    @Published var longitude = 128.8784972
    
    var writeDisabled: Bool {
        title.isEmpty || content.isEmpty || image == nil
    }
    
    func write() {
        NetworkRunner.shared.request("/items/lost", method: .post, parameters: WriteModel(title: title, content: content, imageUrl: image ?? "", location: Location(latitude: latitude, longitude: longitude)), isAuthorization: true) { result in
            switch result {
            case .success(_):
                self.successAlert = true
                self.title = ""
                self.content = ""
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


