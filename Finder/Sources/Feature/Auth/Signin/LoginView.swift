import SwiftUI

struct LoginView: View {
    
    @StateObject var loginVM: LoginViewModel = .init()
    @State private var showPassword = false
    @State private var isalert = false

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                VStack {
                    Image(.finderimage)
                        .resizable()
                        .frame(width: 250,height: 90)
                    Text("찾았다!")
                        .font(.custom("Pretendard-Regular", size: 15))
                        .foregroundColor(.maincolor)
                        .bold()
                        .padding(.bottom,40)
                }
                .padding(.bottom,10)
                VStack {
                    Textfield(image: .profil, text: "이메일을 입력하세요", posttext: $loginVM.email)
                        .padding(.vertical,4)
                    
                    CustomSecureField(image: .password, text: "비밀번호를 입력해주세요", posttext: $loginVM.password)
                    
                }
                .padding(.bottom,30)
                VStack {
                    Button {
                        isalert = true
                    } label: {
                        Text("로그인")
                            .font(.custom("Pretendard-SemiBold", size: 20))
                            .bold()
                            .foregroundColor(.white)
                            .frame(width: 313,height: 55)
                            .background(loginVM.isLoginDisabled ? Color.init(uiColor: .systemGray4) : Color.maincolor)
                            .cornerRadius(13)
                            .bold()
                    }
                    .disabled(loginVM.isLoginDisabled)
                    .alert(isPresented: $isalert) {
                        if let loginerrorMessage = loginVM.loginerrorMessage {
                            return Alert(title: Text("로그인 실패"),
                                         message: Text(loginerrorMessage),
                                         dismissButton: .default(Text("확인")))
                        } else {
                            return Alert(title: Text("로그인 성공"),
                                         message: Text("환영합니다!"),
                                         dismissButton: .default(Text("확인")) {
                                loginVM.islogin = true
                            })
                        }
                    }
                }

                HStack {
                    Text("계정이 없으신가요?")
                        .font(.caption2)
                        .foregroundColor(.init(uiColor: .systemGray2))
                        .font(.custom("Pretendard-Regular", size: 13))
                    NavigationLink(destination: SignupView()){
                        Text("회원가입")
                            .font(.caption2)
                            .foregroundColor(Color.maincolor)
                            .font(.custom("Pretendard-Regular", size: 13))
                    }
                }
                .padding(.leading,160)
                .padding(.top,3)
                Spacer()
                Spacer()
            }
            .navigationDestination(isPresented: $loginVM.islogin) {
                MainView()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    LoginView()
}

