//
//  MyView.swift
//  Finder
//
//  Created by dgsw30 on 10/11/24.
//

import SwiftUI

struct MyView: View {
    @Environment(\.openURL) private var openURL
    @StateObject var myVM = MyViewModel()
    @State private var isAlertPresented = false
    let url = Terms.shared
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack {
                    AsyncImage(url: URL(string: myVM.profileImageUrl)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 130,height: 130)
                    } placeholder: {
                        Rectangle()
                            .frame(width: 130,height: 130)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 100))
                    .padding()
                    
                    Text("\(myVM.username)님")
                        .font(.medium(20))
                    Text("이메일: \(myVM.email)")
                    Button {
                        isAlertPresented = true
                    } label: {
                        Text("프로필 수정")
                            .font(.regular(15))
                            .foregroundStyle(.black)
                            .frame(width: 135,height: 35)
                            .background(Color.white)
                            .cornerRadius(5)
                            .shadow(radius: 1)
                    }
                    VStack(spacing: 1) {
                        Text("내정보")
                            .font(.medium(20))
                            .padding(.trailing,260)
                            .padding(.vertical,4)
                        VStack {
                            SettingButton(text: "내 글", action: {}, color: .black)
                            SettingButton(text: "내 댓글", action: {}, color: .black)
                        }
                        .background(Color.backgroundcolor)
                        .frame(width: 344, height: 108)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.init(uiColor: .systemGray4),lineWidth: 1)
                        )
                    }
                    .padding(.bottom,44)
                    
                    VStack(spacing: 1) {
                        Text("설정")
                            .font(.medium(20))
                            .padding(.trailing,285)
                            .padding(.vertical,4)
                        VStack {
                            SettingButton(text: "개인정보처리약관", action: {
                                if let url = url.url {
                                    openURL(url)
                                }
                            }, color: .black)
                            SettingButton(text: "이용약관", action: {
                                if let url = url.url {
                                    openURL(url)
                                }
                            }, color: .black)
                            LogOutButton()
                                .padding(.top,1)
                            DeleteUser()
                        }
                        .background(Color.backgroundcolor)
                        .frame(width: 344, height: 227)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.init(uiColor: .systemGray4),lineWidth: 1)
                        )
                    }
                }
            }
        }
        .finderAlert(isPresented: $myVM.patchComplete, message: nil, text: "정보수정 완료")
            .padding()
            .backButton()
            .onAppear {
                myVM.fetchMy()
            }
            .overlay {
                if isAlertPresented {
                    UpdateProfileView(userVM: myVM, isPresented: $isAlertPresented)
                        .animation(.easeInOut, value: isAlertPresented)
                        .ignoresSafeArea()
                }
            }
    }
}


#Preview {
    MyView()
}
