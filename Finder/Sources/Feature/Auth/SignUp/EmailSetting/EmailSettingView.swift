//
//  EmailAuthenticationView.swift
//  Finder
//
//  Created by dgsw30 on 9/10/24.
//

//TODO: 이메일인증뷰
import SwiftUI

struct EmailSettingView: View {
    @ObservedObject var emailVM = SignUpViewModel()
    var isAble: Bool {
        emailVM.checkEmail(str: emailVM.email) != true
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
                FinderTextField(image: .profil, text: "이메일을 입력하세요.", posttext: $emailVM.email)
            }
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            NavigationLink(destination: PasswordSettingView(passWordVM: emailVM)) {
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
            .backButton()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    ProgressBar(progress: .three)
                        .padding(.trailing,155)
                }
            }
    }
}

#Preview {
    EmailSettingView()
}
