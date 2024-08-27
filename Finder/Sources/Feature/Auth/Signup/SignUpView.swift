import SwiftUI

struct SignupView: View {
    
    @StateObject var signupVM: SignUpViewModel = .init()
    
    @State private var showPassword = false
    @State private var showcheckPassword = false
    @State private var showingAlert = false
    @State private var shouldNavigateToFirstView = false
    @State private var Error = false
    @Environment(\.dismiss) var dismiss
    
    
    
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
                        
                        TextField("이메일을 입력하세요.", text: $signupVM.request.email)
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
                        
                        TextField("닉네임을 입력하세요.", text: $signupVM.request.username)
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
                            TextField("비밀번호를 입력하세요", text: $signupVM.request.password)
                                .font(.system(size: 15))
                                .padding(.leading, 10)
                                .frame(height: 50)
                        } else {
                            SecureField("비밀번호를 입력하세요.", text: $signupVM.request.password)
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
                            TextField("비밀번호를 한번 더 입력하세요", text: $signupVM.request.checkpassword)
                                .font(.system(size: 15))
                                .padding(.leading, 10)
                                .frame(height: 50)
                        } else {
                            SecureField("비밀번호를 한번 더 입력하세요.", text: $signupVM.request.checkpassword)
                                .font(.system(size: 15))
                                .padding(.leading, 10)
                                .frame(height: 50)
                        }
                        if signupVM.request.password == signupVM.request.checkpassword && !signupVM.request.checkpassword.isEmpty {
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
                        signupVM.signUp()
                        showingAlert = true
                    }) {
                        Text("회원가입")
                            .font(.system(size: 20))
                            .bold()
                            .foregroundColor(.white)
                            .frame(width: 330, height: 60)
                            .background(signupVM.isSignupDisabled ? Color.init(uiColor: .systemGray4) : Color.maincolor)
                            .cornerRadius(13)
                            .padding(15)
                    }
                    .disabled(signupVM.isSignupDisabled)
                    .alert(isPresented: $showingAlert) {
                        if let signuperrorMessage = signupVM.signuperrorMessage {
                            Alert(title: Text("회원가입 실패"),
                                  message: Text(signuperrorMessage),
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
                .navigationDestination(isPresented: $shouldNavigateToFirstView) {
                    LoginView()
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
