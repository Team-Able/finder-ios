import SwiftUI

@main
struct FinderApp: App {
    @StateObject var viewModel = LoginViewModel()
    var body: some Scene {
        WindowGroup {
//            if viewModel.islogin {
//                MainView()
//            } else {
                LoginView()
//            }
        }
    }
}
