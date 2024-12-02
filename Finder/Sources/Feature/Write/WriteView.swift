import SwiftUI
import MapKit
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var userLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            userLocation = location.coordinate
            locationManager.stopUpdatingLocation()
        }
    }
}

struct WriteView: View {
    @StateObject var imageVM = ImageUploadViewModel()
    @StateObject var writeVM = WriteViewModel()
    @StateObject var viewModel = LostItemViewModel()
    @StateObject private var locationManager = LocationManager()
    
    @State private var showingMapKit = false
    @State private var showImagePicker = false
    
    @State private var selectedLatitude: Double = 0.0
    @State private var selectedLongitude: Double = 0.0
    
    let postText = "이미지를 등록 해주세요"
    let textColor = TextColor(color: .primary900)
    
    var body: some View {
        VStack {
            Header()
            ScrollView {
                ZStack {
                    if writeVM.item.title.isEmpty {
                        Text("제목을 작성해주세요")
                            .font(.regular(17))
                            .padding(.trailing, 185)
                    }
                    TextField("", text: $writeVM.item.title, axis: .vertical)
                        .padding(.leading, 16)
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
                    if let userLocation = locationManager.userLocation {
                        MapView(latitude: $selectedLatitude, longitude: $selectedLongitude, initialLatitude: userLocation.latitude, initialLongitude: userLocation.longitude)
                            .edgesIgnoringSafeArea(.all)
                            .presentationDetents([.fraction(0.85)])
                    } else {
                        Text("현재 위치를 가져오는 중입니다...")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .padding()
                    }
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
                        TextEditor(text: $writeVM.item.content)
                            .autocapitalization(.none)
                            .frame(height: 280)
                            .tint(Color.primary600)
                            .overlay {
                                if writeVM.item.content.isEmpty {
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
                        writeVM.postwrite()
                    } label: {
                        Text("게시 하기")
                            .font(.bold(22))
                            .foregroundColor(.white)
                            .frame(width: 330, height: 60)
                            .background(writeVM.item.content.isEmpty || writeVM.item.title.isEmpty ? Color.init(uiColor: .systemGray4): .primary500)
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
