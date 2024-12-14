import SwiftUI

@main
struct FinderApp: App {
    @AppStorage("accessToken")
    private var accessToken: String?
    
    var body: some Scene {
        WindowGroup {
            if accessToken == nil {
                LoginView()
            } else {
                CustomTabView()
            }
        }
    }
}

