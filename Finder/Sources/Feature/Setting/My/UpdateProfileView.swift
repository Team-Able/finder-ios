//
//  UpdateProfileView.swift
//  Finder
//
//  Created by dgsw30 on 10/13/24.
//

import SwiftUI

struct UpdateProfileView: View {
    @State private var changeUserName = ""
    //hello
    @Environment(\.dismiss) var dismiss
    @Binding var isPresented: Bool
    var body: some View {
        ZStack {
            Color.black.opacity(0.2)
                .ignoresSafeArea(.all)
                .onTapGesture {
                    isPresented = false
                }
            
            VStack {
                VStack {
                    Image(.myimage)
                        .padding()
                    Button {
                        
                    } label: {
                        Text("사진 변경하기")
                            .font(.semibold(12))
                            .foregroundStyle(.primary900)
                            .underline()
                            .padding(.bottom,4)
                    }
                    .padding(.bottom,14)
                    VStack {
                        TextField("유저이름", text: $changeUserName)
                    }
                    .padding()
                    .frame(width: 245,height: 36)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.init(uiColor: .systemGray4),lineWidth: 1)
                    )
                    HStack {
                        VStack {
                            Divider()
                            Button {
                                if !changeUserName.isEmpty {
                                    isPresented = false
                                }
                            } label: {
                                VStack {
                                    Text("수정완료")
                                        .font(.regular(18))
                                        .padding()
                                        .cornerRadius(10)
                                        .foregroundStyle(changeUserName.isEmpty ? Color.init(uiColor: .systemGray4) : Color.primary900)
                                }
                                .disabled(changeUserName.isEmpty)
                            }
                        }
                    }
                    .padding(.top, 44)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .padding(.horizontal, 50)
                .padding(.vertical, 120)
                
            }
            .frame(maxWidth: 500, maxHeight: 550)
        }
    }
}
