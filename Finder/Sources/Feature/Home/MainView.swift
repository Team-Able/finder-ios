import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewModel: LoginViewModel
    @State private var toFirst = false

    var body: some View {
        VStack {
            Button {
                logout()
            } label: {
                Text("로그아웃")
            }
        }
        .navigationDestination(isPresented: $toFirst) {
            LoginView()
                .environmentObject(viewModel)
        }
        .navigationBarBackButtonHidden()
    }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: "accessToken")
        UserDefaults.standard.removeObject(forKey: "refreshToken")
        self.viewModel.islogin = false
        toFirst = true
        print("토큰삭제됨")
    }
}

