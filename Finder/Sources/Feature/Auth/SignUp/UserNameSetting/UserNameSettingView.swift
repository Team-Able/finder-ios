//
//  AreasettingView.swift
//  Finder
//
//  Created by dgsw30 on 9/10/24.
//


//TODO: 이름받기
import SwiftUI

struct UserNameSettingView: View {
    @ObservedObject var usernameVM = SignUpViewModel()
    var isAble: Bool {
        usernameVM.username.count < 3 || usernameVM.username.count > 20
    }
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text("이름을 입력해주세요")
                    .font(.bold(22))
                    .padding(.leading,48)
                Spacer()
            }
            .padding(.bottom,30)
            VStack {
                FinderTextField(image: .profil, text: "이름을 입력하세요.", posttext: $usernameVM.username)
            }
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            NavigationLink(destination: EmailSettingView(emailVM: usernameVM)) {
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
                    ProgressBar(progress: .two)
                        .padding(.trailing,155)
                }
            }
    }
}

#Preview {
    UserNameSettingView()
}
