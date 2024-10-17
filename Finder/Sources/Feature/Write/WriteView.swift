import SwiftUI
import MapKit
//MARK: 지도 버튼 만들어야됨

struct WriteView: View {
    @StateObject var imageVM = ImageUploadViewModel()
    @StateObject var writeVM = WriteViewModel()
    
    @State private var showingMapKit = false
    @State private var showImagePicker = false // 이미지 토글
    
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
                            .padding(.trailing, 185)
                    }
                    TextField("", text: $writeVM.title, axis: .vertical)
                        .padding(.leading, 16)
                        .padding(.trailing, 16)
                        .tint(Color.primary600)
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
                        .frame(width: 344 ,height: 48)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.init(uiColor: .systemGray4))
                        }
                }
                .padding(.vertical, 4)
                .sheet(isPresented: $showingMapKit) {
                    MapView()
                        .edgesIgnoringSafeArea(.all)
                        .presentationDetents([.fraction(0.85)])
                }
                
                VStack {
                    Button {
                        showImagePicker.toggle()
                    } label: {
                        ZStack {
                            Text(textColor.attributedString(for: postText, targetWord: "등록"))
                                .font(.regular(18))
                                .foregroundColor(.black)
                                .frame(width: 344, height: 60)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.init(uiColor: .systemGray4))
                                }
                        }
                        .sheet(isPresented: $showImagePicker) {
                            ImagePicker(image: $imageVM.image)
                                .presentationDetents([.fraction(0.8)])
                        }
                    }
                    VStack {
                        TextEditor(text: $writeVM.content)
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
                    .padding(.horizontal, 12)
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(Color.init(uiColor: .systemGray2))
                        .padding()
                    
                    if let image = imageVM.image {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .onAppear {
                                imageVM.uploadImage()
                            }
                    }
                    
                    if let imageUrl = imageVM.imageUrl {
                        Text("\(imageUrl)")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                            .padding()
                            .multilineTextAlignment(.center)
                    }
                    
                    Button {
                        //MARK: post 기능 추가
                    } label: {
                        Text("게시 하기")
                            .font(.bold(22))
                            .foregroundColor(.white)
                            .frame(width: 330, height: 60)
                            .background(writeVM.content.isEmpty || writeVM.title.isEmpty ? Color.init(uiColor: .systemGray4): .primary500)
                            .cornerRadius(13)
                            .padding(17)
                    }
                }
            }
        }
        .padding()
        Spacer()
            .navigationBarBackButtonHidden()
    }
}

#Preview {
    WriteView()
}
