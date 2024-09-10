import SwiftUI

@main
struct FinderApp: App {
    @ObservedObject var loginVM: LoginViewModel = .init()
    var body: some Scene {
        WindowGroup {
            if loginVM.islogin == true {
                MainView()
            } else {
                LoginView()
            }
        }
    }
}
