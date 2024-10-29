import Alamofire
import Foundation

class WriteViewModel: ObservableObject {
    @Published var title = ""
    @Published var content = ""
    @Published var imageUrl = ""
    @Published var location: Location = Location(latitude: 0.0, longitude: 0.0)
}
//TODO: 검색, 홈, 글쓰기(post, 위치 검색해서 마크찍기)
