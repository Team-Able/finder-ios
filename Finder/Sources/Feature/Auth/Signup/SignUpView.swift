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
                
                VStack(spacing: 10) {
                    Textfield(image: .profil, text: "이메일을 입력하세요", posttext: $signupVM.request.email)
                    
                    Textfield(image: .profil, text: "닉네임을 입력해주세요", posttext: $signupVM.request.username)
                    
                    Textfield(image: .password, text: "비밀번호를 입력해주세요", posttext: $signupVM.request.password)
                }
                
            }
            Spacer()
            Spacer()
            VStack {
                Spacer()
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
        .padding()
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
    SignupView()
}