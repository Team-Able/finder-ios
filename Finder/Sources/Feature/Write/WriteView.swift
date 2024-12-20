import SwiftUI

struct WriteView: View {
    @StateObject var imageVM = ImageUploadViewModel()
    @StateObject var writeVM = WriteViewModel()
    @State private var showingMapKit = false
    @State private var showImagePicker = false
    @State private var existingImage = false
    
    let postText = "이미지를 등록 해주세요"
    let textColor = TextColor(color: .primary900)
    
    var body: some View {
        VStack {
            Header()
            ScrollView {
                ZStack {
                    if writeVM.title.isEmpty {
                        Text("제목을 작성해주세요")
                            .font(.regular(17))
                            .padding(.trailing, 195)
                    }
                    TextField("", text: $writeVM.title, axis: .vertical)
                        .padding(.leading, 24)
                        .padding(.trailing, 16)
                        .tint(Color.primary600)
                        .autocapitalization(.none)
                }
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color.init(uiColor: .systemGray2))
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                    .padding(.bottom, 6)
                
                Button {
                    showingMapKit.toggle()
                } label: {
                    Text("어디서 잃어버리셨나요?")
                        .font(.regular(17))
                        .foregroundColor(.black)
                        .frame(width: 344, height: 48)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.init(uiColor: .systemGray4))
                        }
                }
                .padding(.vertical, 4)
                .sheet(isPresented: $showingMapKit) {
                    ChooseLocate()
                        .ignoresSafeArea()
                }
                
                VStack {
                    Button {
                        showImagePicker.toggle()
                    } label: {
                        ZStack {
                            if existingImage {
                                Text("이미지는 한장만 첨부 가능합니다")
                                    .font(.regular(18))
                                    .foregroundStyle(.black)
                                    .frame(width: 344, height: 60)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.init(uiColor: .systemGray4))
                                    }
                            } else {
                                Text(textColor.attributedString(for: postText, targetWord: "등록"))
                                    .font(.regular(18))
                                    .foregroundColor(.black)
                                    .frame(width: 344, height: 60)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.init(uiColor: .systemGray4))
                                    }
                            }
                        }
                        .sheet(isPresented: $showImagePicker) {
                            ImagePicker(image: $imageVM.image)
                                .onDisappear {
                                    if imageVM.image != nil {
                                        existingImage = true
                                        imageVM.getImageUrl { imageUrl in
                                            print(imageUrl ?? "")
                                        }
                                    } else {
                                        print("이미지를 선택하지 않았습니다.")
                                    }
                                }
                        }
                    }
                    VStack {
                        TextEditor(text: $writeVM.content)
                            .autocapitalization(.none)
                            .frame(height: 280)
                            .tint(Color.primary600)
                            .overlay {
                                if writeVM.content.isEmpty {
                                    Text("본문을 작성해주세요")
                                        .font(.regular(18))
                                        .padding(.bottom, 244)
                                        .padding(.trailing, 180)
                                }
                            }
                    }
                    .padding()
                    .padding(.horizontal, 12)
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(Color.init(uiColor: .systemGray2))
                        .padding()
                    
                    //TODO: 이미지 불러오기 수정
                    if let image = imageVM.imageUrl {
                        let imageUrl = URL(string: image)
                        AsyncImage(url: imageUrl) { image in
                            VStack {
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 330, height: 171)
                                Button {
                                    imageVM.imageUrl = ""
                                    existingImage = false
                                } label: {
                                    HStack {
                                        Spacer()
                                        Text("이미지 삭제하기")
                                            .frame(width: 120, height: 34)
                                            .background(Color.red)
                                            .foregroundStyle(.white)
                                            .font(.semibold(18))
                                            .cornerRadius(8)
                                    }
                                    .padding()
                                }
                            }
                        } placeholder: {}
                    }
                    
                    Button {
                        writeVM.image = imageVM.imageUrl ?? ""
                        writeVM.write()
                    } label: {
                        Text("게시 하기")
                            .font(.bold(22))
                            .foregroundColor(.white)
                            .frame(width: 330, height: 60)
                            .background(writeVM.writeDisabled || imageVM.imageUrl == nil ? Color.init(uiColor: .systemGray4): .primary500)
                            .cornerRadius(13)
                            .padding(17)
                    }
                    .disabled(writeVM.writeDisabled || imageVM.imageUrl == nil)
                }
            }
        }
        Spacer()
            .hideKeyBoard()
            .finderAlert(isPresented: $writeVM.successAlert, message: "글이 성공적으로 업로드 되었어요", text: "업로드 성공!")
            .onChange(of: writeVM.successAlert) { newValue in
                imageVM.imageUrl = ""
            }
    }
}

#Preview {
    WriteView()
}
