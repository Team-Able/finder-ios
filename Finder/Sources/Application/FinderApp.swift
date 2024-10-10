import SwiftUI

@main
struct FinderApp: App {
    @StateObject var viewModel = LoginViewModel()
    
    var body: some Scene {
        WindowGroup {
            if viewModel.islogin {
                TabView()
                    .environmentObject(viewModel)
            } else {
                LoginView()
                    .environmentObject(viewModel)
                    .onAppear {
                        checkLoginStatus()
                    }
            }
        }
    }
    private func checkLoginStatus() {
        if let accessToken = UserDefaults.standard.string(forKey: "accessToken") {
            viewModel.islogin = true
        } else {
            viewModel.islogin = false
        }
    }
}

