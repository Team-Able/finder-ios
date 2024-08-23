import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showPassword = false
    @State private var islogin = false
    @State private var isalert = false
    
    var isLoginDisabled: Bool {
        email.isEmpty || password.isEmpty
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Image(.finderimage)
                    .resizable()
                    .frame(width: 250,height: 90)
                Text("찾았다!")
                    .foregroundColor(.maincolor)
                    .bold()
                    .padding()
                Spacer()
                
                VStack(spacing: 20) {
                    HStack {
                        Image(.profil)
                            .resizable()
                            .frame(width: 20,height: 20)
                            .padding(.leading, 12)
                        
                        TextField("이메일을 입력하세요.", text: $email)
                            .font(.system(size: 15))
                            .padding(.leading,11)
                            .frame(height: 50)
                    }
                    .background(Color.backgroundcolor)
                    .frame(width: 300, height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.maincolor, lineWidth: 1)
                    )
                    
                    HStack {
                        Image(.password)
                            .resizable()
                            .frame(width: 20,height: 25)
                            .padding(.leading, 13)
                        
                        if showPassword {
                            TextField("비밀번호를 입력하세요", text: $password)
                                .font(.system(size: 15))
                                .padding(.leading, 10)
                                .frame(height: 50)
                        } else {
                            SecureField("비밀번호를 입력하세요.", text: $password)
                                .font(.system(size: 15))
                                .padding(.leading, 10)
                                .frame(height: 50)
                        }
                        Button {
                            self.showPassword.toggle()
                        } label: {
                            Image(systemName: showPassword ? "eye.slash" : "eye")
                                .foregroundColor(.gray)
                                .padding(.trailing, 12)
                        }
                        
                    }
                    .background(Color.backgroundcolor)
                    .frame(width: 300, height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.maincolor, lineWidth: 1)
                    )
                }
                Spacer()
                Spacer()
                VStack {
                    HStack {
                        Text("계정이 없으신가요?")
                            .font(.caption2)
                            .foregroundColor(.init(uiColor: .systemGray2))
                        NavigationLink(destination: SignupView()){
                            Text("회원가입")
                                .font(.caption2)
                                .foregroundColor(Color.maincolor)
                        }
                    }
                    
                    
                    Button {
                        postlogin(email: "", password: "" ) { result in
                            switch result {
                            case.success(let response):
                                print("로그인 성공, 응답: \(response)")
                                islogin = true
                            case .failure(let error):
                                print("로그인 실패. 에러: \(error)")
                                isalert = true
                            }
                        }
                    } label: {
                        Text("로그인")
                            .font(.system(size: 20))
                            .bold()
                            .foregroundColor(.white)
                            .frame(width: 330,height: 60)
                            .background(isLoginDisabled ? Color.init(uiColor: .systemGray4) : Color.maincolor)
                            .cornerRadius(13)
                            .padding(10)
                            .bold()
                            .alert(isPresented: $isalert) {
                                Alert(title: Text("로그인 실패"),
                                      message: Text("이메일과 비밀번호를 다시 확인해주세요."),
                                      dismissButton: .default(Text("확인")))
                                
                            }
                    }
                }
                
                NavigationLink(destination: MainView(), isActive: $islogin) {
                    EmptyView()
                }
                
                .disabled(isLoginDisabled)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    LoginView()
}
