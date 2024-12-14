//
//  TermsView.swift
//  Finder
//
//  Created by dgsw30 on 10/8/24.
//

import SwiftUI

struct PermitView: View {
    @StateObject var permitVM = PermitViewModel()
    var acceptAllow: Bool {
        permitVM.isTermsAccepted && permitVM.isPrivacyPolicyAccepted && permitVM.isNotificationOptedIn
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Finder")
                    .font(.bold(32))
                    .foregroundStyle(.primary500)
                    .padding(.horizontal,4)
                Text("약관동의")
                    .font(.bold(24))
                Spacer()
            }
            .padding(.leading,24)
            
            ZStack {
                Rectangle()
                    .fill(Color.allaccept)
                    .frame(width: 345,height: 50)
                    .cornerRadius(14)
                HStack {
                    Button {
                        if permitVM.allSelected {
                            permitVM.isTermsAccepted = false
                            permitVM.isPrivacyPolicyAccepted = false
                            permitVM.isNotificationOptedIn = false
                        } else {
                            permitVM.isTermsAccepted = true
                            permitVM.isPrivacyPolicyAccepted = true
                            permitVM.isNotificationOptedIn = true
                        }
                    } label: {
                        Image(systemName: permitVM.allSelected ? "checkmark.square.fill" : "square")
                            .resizable()
                            .frame(width: 18,height: 19)
                            .foregroundStyle(.primary500)
                            .padding(.horizontal)
                    }
                    Text("전체동의")
                        .font(.custom("SF-Pro-Display-Medium", size: 20))
                    Spacer()
                }
                .padding(.leading,24)
            }
            .padding(.vertical,24)
            
            VStack {
                HStack {
                    CheckBox(action: {
                        permitVM.isTermsAccepted.toggle()
                    }, accept: permitVM.isTermsAccepted, text: "이용약관")
                    Spacer()
                }
                .padding(.bottom, 14)
                
                HStack {
                    CheckBox(action: {
                        permitVM.isPrivacyPolicyAccepted.toggle()
                    }, accept: permitVM.isPrivacyPolicyAccepted, text: "개인정보 이용약관")
                    Spacer()
                }
                .padding(.bottom, 14)
                
                HStack {
                    CheckBox(action: {
                        permitVM.isNotificationOptedIn.toggle()
                    }, accept: permitVM.isNotificationOptedIn, text: "이용약관")
                    Spacer()
                }
            }
            .padding(.leading, 40)
            Spacer()
            NextButton(destination: UserNameSettingView(), isEnabled: acceptAllow)
        }
        .padding(.top,144)
        .navigationBarBackButtonHidden()
        BackButton()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    ProgressBar(progress: .one)
                        .padding(.trailing,155)
                }
            }
    }
}

#Preview {
    PermitView()
}
