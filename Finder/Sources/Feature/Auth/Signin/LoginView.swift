import SwiftUI

struct LoginView: View {
    
    @StateObject var loginVM: LoginViewModel = .init()
    @State private var showPassword = false
    @State private var isAlert = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                VStack {
                    Image(.finderimage)
                        .resizable()
                        .frame(width: 250,height: 90)
                    Text("찾았다!")
                        .font(.regular(15))
                        .foregroundColor(.primary500)
                        .bold()
                        .padding(.bottom,40)
                }
                .padding(.bottom,10)
                VStack {
                    Textfield(image: .profil, text: "이메일을 입력하세요", posttext: $loginVM.email)
                        .padding(.vertical,4)
                    
                    CustomSecureField(image: .password, text: "비밀번호를 입력해주세요", postText: $loginVM.password)
                    
                }
                .padding(.bottom, 30)
                VStack {
                    Button {
                        loginVM.login()
                        isAlert = loginVM.loginerrorMessage != nil
                    } label: {
                        Text("로그인")
                            .font(.bold(20))
                            .bold()
                            .foregroundColor(.white)
                            .frame(width: 313,height: 55)
                            .background(loginVM.isLoginDisabled ? Color.init(uiColor: .systemGray4) : Color.primary500)
                            .cornerRadius(13)
                            .bold()
                    }
                    .disabled(loginVM.isLoginDisabled)
                    .alert(isPresented: $isAlert) {
                        Alert(title: Text("로그인 실패"),
                              message: Text(loginVM.loginerrorMessage ?? "알 수 없는 오류입니다."),
                              dismissButton: .default(Text("확인")))
                    }
                }
                HStack {
                    Text("계정이 없으신가요?")
                        .font(.caption2)
                        .foregroundColor(.init(uiColor: .systemGray2))
                        .font(.regular(13))
                    NavigationLink(destination: PermitView()){
                        Text("회원가입")
                            .font(.caption2)
                            .foregroundColor(.primary800)
                            .font(.regular(13))
                    }
                }
                .padding(.leading,160)
                .padding(.top,3)
                Spacer()
                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    LoginView()
}

