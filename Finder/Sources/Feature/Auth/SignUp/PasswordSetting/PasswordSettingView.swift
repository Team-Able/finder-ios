//
//  PasswordsettingView.swift
//  Finder
//
//  Created by dgsw30 on 9/10/24.
//

//TODO: 비밀번호설정뷰
import SwiftUI

struct PasswordSettingView: View {
    @ObservedObject var passWordVM: SignUpViewModel = .init()
    @State private var checkPassWord = ""
    @State private var check = false
    var passwordDisabled: Bool {
        passWordVM.password.count < 8 || passWordVM.password.count > 32 || checkPassWordBolean == false
    }
    var checkPassWordBolean: Bool {
        passWordVM.password == checkPassWord && !checkPassWord.isEmpty
    }
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text("비밀번호를 설정해 주세요")
                    .font(.bold(22))
                    .padding(.leading,48)
                Spacer()
            }
            .padding(.bottom,30)
            VStack {
                FinderSecureField(image: .password, text: "비밀번호를 입력해주세요 8자", postText: $passWordVM.password)
                
                CheckPassWord(text: "비밀번호를 재입력해주세요", check: checkPassWordBolean, postText: $checkPassWord)
            }
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            NavigationLink(destination: SettingDoneView(signupVM: passWordVM)) {
                Text("다음")
                    .font(.bold(22))
                    .foregroundColor(.white)
                    .frame(width: 330, height: 60)
                    .background(passwordDisabled ? Color.init(uiColor: .systemGray4) : .primary500)
                    .cornerRadius(13)
                    .padding(15)
            }
            .disabled(passwordDisabled)
        }
        Spacer()
            .backButton()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    ProgressBar(progress: .four)
                        .padding(.trailing,155)
                }
            }
    }
}

#Preview {
    PasswordSettingView()
}
