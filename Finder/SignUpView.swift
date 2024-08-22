import SwiftUI

struct SignupView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var checkpassword = ""
    @State private var username = ""
    @State private var showPassword = false
    @State private var showcheckPassword = false
    @State private var showingAlert = false
    @State private var shouldNavigateToFirstView = false
    @State private var Error = false
    @Environment(\.dismiss) var dismiss
    
    var isLoginDisabled: Bool {
        email.isEmpty || password.isEmpty || checkpassword.isEmpty || password != checkpassword || username.isEmpty
    }
    
    var body: some View {
        VStack {
            VStack {
                Spacer()
                VStack {
                    VStack {
                        Text("회원가입을 위해 정보를 \n입력해주세요.")
                            .font(.system(size: 22))
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading,50)
                    }
                }
                Spacer()
                
                VStack(spacing: 20) {
                    HStack {
                        Image(systemName: "envelope.circle")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color.gray)
                            .padding(.leading, 12)
                        
                        TextField("이메일을 입력하세요.", text: $email)
                            .font(.system(size: 15))
                            .padding(.leading, 11)
                            .frame(height: 50)
                    }
                    .background(Color.backgroundcolor)
                    .frame(width: 300, height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.maincolor, lineWidth: 1)
                    )
                    
                    HStack {
                        Image(.profil)
                            .resizable()
                            .frame(width: 20, height: 20)
                            .padding(.leading, 12)
                        
                        TextField("닉네임을 입력하세요.", text: $username)
                            .font(.system(size: 15))
                            .padding(.leading, 11)
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
                            .frame(width: 20, height: 25)
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
                    
                    HStack {
                        Image(.password)
                            .resizable()
                            .frame(width: 20, height: 25)
                            .padding(.leading, 13)
                        
                        if showcheckPassword {
                            TextField("비밀번호를 한번 더 입력하세요", text: $checkpassword)
                                .font(.system(size: 15))
                                .padding(.leading, 10)
                                .frame(height: 50)
                        } else {
                            SecureField("비밀번호를 한번 더 입력하세요.", text: $checkpassword)
                                .font(.system(size: 15))
                                .padding(.leading, 10)
                                .frame(height: 50)
                        }
                        if password == checkpassword && !checkpassword.isEmpty {
                            Image(systemName: "checkmark")
                                .foregroundColor(.maincolor)
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
                    Button(action: {
                        showingAlert = true
                        postSignup(email: email, password: password, userName: username){ response in
                            switch response {
                            case .success(let response):
                                print("로그인 성공, 응답: \(response)")
                                Error = false
                            case .failure(let error):
                                print("로그인 실패, 에러: \(error)")
                                Error = true
                            }
                        }
                    }) {
                        Text("회원가입")
                            .font(.system(size: 20))
                            .bold()
                            .foregroundColor(.white)
                            .frame(width: 330, height: 60)
                            .background(isLoginDisabled ? Color.init(uiColor: .systemGray4) : Color.maincolor)
                            .cornerRadius(13)
                            .padding(15)
                    }
                    .disabled(isLoginDisabled)
                    .alert(isPresented: $showingAlert) {
                        if Error {
                            Alert(title: Text("회원가입 실패"),
                                         message: Text("예상치 못한 오류가 발생했습니다."),
                                         dismissButton: .default(Text("확인")))
                        } else {
                            Alert(title: Text("회원가입 완료"),
                                         message: Text("이메일과 비밀번호를 기억해주세요."),
                                         dismissButton: .default(Text("확인")) {
                                shouldNavigateToFirstView = true
                            })
                        }
                    }
                }
                NavigationLink(destination: LoginView(), isActive: $shouldNavigateToFirstView) {
                    EmptyView()
                }
            }
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
            }
        }
    }
}

#Preview {
    SignupView()
}
