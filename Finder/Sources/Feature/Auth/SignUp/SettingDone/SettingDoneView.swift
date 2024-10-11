//
//  SettingDoneView.swift
//  Finder
//
//  Created by dgsw30 on 10/10/24.
//

import SwiftUI

struct SettingDoneView: View {
    @StateObject var signupVM: SignUpViewModel = .init()
    @State private var toFirstView = false
    @State private var showingAlert = false
    @State private var isHidden = true
    var body: some View {
        VStack {
            if !isHidden {
                UserNameSettingView(usernameVM: signupVM)
                EmailSettingView(emialVM: signupVM)
                PasswordSettingView(passWordVM: signupVM)
            }
            Spacer()
            Image(.done)
            Spacer()
            Button(action: {
                signupVM.signUp()
                showingAlert = true
            }) {
                Text("회원가입 완료")
                    .font(.system(size: 20))
                    .bold()
                    .foregroundColor(.white)
                    .frame(width: 330, height: 60)
                    .background(Color.primary500)
                    .cornerRadius(13)
                    .padding(15)
            }
        }
        .alert(isPresented: $showingAlert) {
            if let signuperrorMessage = signupVM.signuperrorMessage {
                Alert(title: Text("회원가입 실패"),
                      message: Text(signuperrorMessage),
                      dismissButton: .default(Text("확인")))
            } else {
                Alert(title: Text("회원가입 완료"),
                      message: Text("이메일과 비밀번호를 기억해주세요."),
                      dismissButton: .default(Text("확인")) {
                    toFirstView = true
                })
            }
        }
        .navigationDestination(isPresented: $toFirstView) {
            LoginView()
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    SettingDoneView()
}
