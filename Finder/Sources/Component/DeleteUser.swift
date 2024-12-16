//MARK: 이름수정
import SwiftUI

struct DeleteUser: View {
    @StateObject var myVM = MyViewModel()
    @State private var showingAlert = false

    var body: some View {
        VStack {
            Button {
                showingAlert = true
            } label: {
                VStack {
                    HStack {
                        Text("회원탈퇴")
                            .foregroundColor(.red)
                            .font(.regular(17))
                            .padding()
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.black)
                            .padding()
                    }
                    .frame(width: 344,height: 50)
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(
                        color: Color(.sRGBLinear, white: 0, opacity: 0.1),
                        radius: 0.5, x: 0.5, y: 1
                    )
                }
            }
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("회원탈퇴"),
                    message: Text("정말 회원탈퇴 하시겠습니까?"),
                    primaryButton: .default(Text("취소"))
                    {
                    },
                    secondaryButton: .destructive(Text("회원탈퇴")) {
                        myVM.deleteMy()
                    }
                )
            }
        }
    }
}

