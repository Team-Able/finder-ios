//
//  UpdateProfileView.swift
//  Finder
//
//  Created by dgsw30 on 10/13/24.
//

import SwiftUI

struct UpdateProfileView: View {
    @StateObject private var imageVM = ImageUploadViewModel()
    @ObservedObject var userVM: MyViewModel
    @State private var imageChange = false
    @State private var existingImage = false
    @State private var changeUserName = ""
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.2)
                .onTapGesture {
                    isPresented = false
                }
            
            VStack {
                ZStack {
                    AsyncImage(url: URL(string: userVM.profileImageUrl)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 113, height: 115)
                    } placeholder: {
                        Rectangle()
                            .frame(width: 113, height: 115)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 100))
                    .padding()
                    
                    if existingImage {
                        if let imageUrl = imageVM.imageUrl {
                            AsyncImage(url: URL(string: imageUrl)) { image in
                                image
                                    .resizable()
                                    .frame(width: 113, height: 115)
                            } placeholder: {
                                Rectangle()
                                    .frame(width: 113, height: 115)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 100))
                        }
                    }
                }
                
                Button {
                    imageChange = true
                } label: {
                    Text("사진 변경하기")
                        .font(.semibold(12))
                        .foregroundStyle(.primary900)
                        .underline()
                        .padding(.bottom, 4)
                }
                .sheet(isPresented: $imageChange) {
                    ImagePicker(image: $imageVM.image)
                        .onDisappear {
                            imageVM.getImageUrl { imageUrl in
                                existingImage = true
                            }
                        }
                }
                .padding(.bottom, 14)
                
                VStack {
                    TextField("유저이름", text: $changeUserName)
                }
                .padding()
                .frame(width: 245, height: 36)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.init(uiColor: .systemGray4), lineWidth: 1)
                )
                .hideKeyBoard()
                
                VStack {
                    Rectangle()
                        .fill(Color.progress)
                        .frame(width: 283, height: 1)
                        .padding(.top, 14)
                    
                    Button {
                        if let imageUrl = imageVM.imageUrl {
                            userVM.patchMy(imageUrl: imageUrl, userName: changeUserName)
                        }
                        isPresented = false
                    } label: {
                        VStack {
                            Text("수정완료")
                                .font(.regular(18))
                                .cornerRadius(10)
                                .foregroundStyle(changeUserName.isEmpty || imageVM.imageUrl == nil ? Color.init(uiColor: .systemGray4) : Color.primary900)
                                .padding(.bottom, 5)
                                .frame(width: 273, height: 25)
                        }
                        .padding(.vertical, 10)
                    }
                    .disabled(changeUserName.isEmpty || imageVM.imageUrl == nil)
                }
                .padding(.top, 14)
            }
            .background(Color.white)
            .cornerRadius(20)
            .padding(.horizontal, 150)
            .padding(.vertical, 120)
        }
    }
}
