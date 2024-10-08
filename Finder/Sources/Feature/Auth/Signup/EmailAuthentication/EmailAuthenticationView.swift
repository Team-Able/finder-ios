//
//  EmailAuthenticationView.swift
//  Finder
//
//  Created by dgsw30 on 9/10/24.
//

//TODO: 이메일인증뷰
import SwiftUI

struct EmailAuthenticationView: View {
    @StateObject var signupVM: SignUpViewModel = .init()
    @Environment(\.dismiss) var dismiss
    var isAble: Bool {
        signupVM.checkEmail(str: signupVM.email) != true
    }
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text("이메일을 입력해주세요")
                    .font(.bold(22))
                    .padding(.leading,48)
                Spacer()
            }
            .padding(.bottom,30)
            VStack {
                Textfield(image: .profil, text: "이메일을 입력하세요.", posttext: $signupVM.email)
            }
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            NavigationLink(destination: PasswordsettingView()) {
                Text("다음")
                    .font(.bold(22))
                    .foregroundColor(.white)
                    .frame(width: 330, height: 60)
                    .background(isAble ? Color.init(uiColor: .systemGray4) : .primary500)
                    .cornerRadius(13)
                    .padding(15)
            }
            .disabled(isAble)
        }
        Spacer()
            .navigationBarBackButtonHidden()
        BackButton()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    ProgressBar(progress: .two)
                        .padding(.trailing,155)
                }
            }
    }
}

#Preview {
    EmailAuthenticationView()
}
