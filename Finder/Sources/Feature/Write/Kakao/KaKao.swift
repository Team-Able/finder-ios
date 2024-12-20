//import SwiftUI
//import KakaoMapsSDK
//
//extension Bundle {
//    var apiKey: String? {
//        return infoDictionary?["API_KEY"] as? String
//    }
//}
//
//struct ContentView: View {
//    @State private var draw: Bool = false
//    
//    var body: some View {
//        MapView(draw: $draw).onAppear(perform: {
//            self.draw = true
//        }).onDisappear(perform: {
//            self.draw = false
//        }).frame(maxWidth: .infinity, maxHeight: .infinity)
//    }
//}
