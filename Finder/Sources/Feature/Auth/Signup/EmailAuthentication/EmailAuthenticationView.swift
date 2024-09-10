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
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text("이메일 입력 후,\n인증을 진행해 주세요")
                    .font(.custom("Pretendard-SemiBold", size: 22))
                    .padding(.leading,48)
                Spacer()
            }
            .padding(.bottom,30)
            VStack {
                Textfield(image: .profil, text: "이메일을 입력하세요.", posttext: $signupVM.request.email)
                
                Textfield(image: .password, text: "인증번호를 입력하세요.", posttext: $signupVM.request.password)
            }
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            NavigationLink(destination: PasswordsettingView()) {
                Text("다음")
                    .font(.custom("Pretendard-SemiBold", size: 22))
                    .foregroundColor(.white)
                    .frame(width: 330, height: 60)
                    .background(signupVM.isSignupDisabled ? Color.init(uiColor: .systemGray4) : Color.maincolor)
                    .cornerRadius(13)
                    .padding(15)
            }
            .disabled(signupVM.isSignupDisabled)
        }
        Spacer()
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                                .bold()
                        }
                    }
                }
                ToolbarItem(placement: .navigation) {
                    ProgressBar()
                }
            }
    }
}

#Preview {
    EmailAuthenticationView()
}
