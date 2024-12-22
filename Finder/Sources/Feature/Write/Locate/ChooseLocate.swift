import SwiftUI
import CoreLocation
import CoreLocationUI

struct ChooseLocate: View {
    @ObservedObject private var locationManager = LocationManager()
    @State private var latitude: Double = 0.0
    @State private var longitude: Double = 0.0
    @State private var errorMessage = false
    @State private var isLocationFound = false
    @State private var draw = true
    private let geocoder = CLGeocoder()
    @State private var address = ""
    
    var body: some View {
        VStack {
            if isLocationFound {
                KakaoMapView(draw: $isLocationFound, longitude: $longitude, latitude: $latitude)
                    .overlay {
                        VStack {
                            HStack {
                                Button {
                                    geocodeAddress(text: address)
                                } label: {
                                    Image(systemName: "magnifyingglass")
                                        .foregroundStyle(.black)
                                        .padding(.leading, 15)
                                }
                                TextField("주소를 검색해주세요", text: $address)
                                    .font(.bold(16))
                                    .frame(height: 50)
                                    .cornerRadius(10)
                                    .padding(.leading, 8)
                                    .padding(.vertical, 2)
                                    .onSubmit {
                                        geocodeAddress(text: address)
                                    }
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            .padding()
                            Spacer()
                        }
                    }
            } else {
                MyLocationMapView(draw: $draw, locationManager: locationManager)
                    .overlay {
                        VStack {
                            HStack {
                                Button {
                                    geocodeAddress(text: address)
                                } label: {
                                    Image(systemName: "magnifyingglass")
                                        .foregroundStyle(.black)
                                        .padding(.leading, 15)
                                }
                                TextField("주소를 검색해주세요", text: $address)
                                    .font(.bold(16))
                                    .frame(height: 50)
                                    .cornerRadius(10)
                                    .padding(.leading, 8)
                                    .padding(.vertical, 2)
                                    .onSubmit {
                                        geocodeAddress(text: address)
                                    }
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            .padding()
                            Spacer()
                        }
                    }
            }
        }
        .finderAlert(isPresented: $errorMessage, message: "주소를 가져오는중 오류가 발생했어요", text: "오류!")
        .padding()
    }
    
    private func geocodeAddress(text: String) {
        geocoder.geocodeAddressString(text) { (placemarks, error) in
            DispatchQueue.main.async {
                if error != nil {
                    self.errorMessage = true
                    return
                }
                
                guard let placemark = placemarks?.first else {
                    self.errorMessage = true
                    return
                }
                
                if let location = placemark.location {
                    self.reset()
                    self.latitude = location.coordinate.latitude
                    self.longitude = location.coordinate.longitude
                    self.errorMessage = false
                    
                    self.isLocationFound = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.isLocationFound = true
                    }
                    
                    print("위도: \(location.coordinate.latitude), 경도: \(location.coordinate.longitude)")
                } else {
                    print("오류")
                }
            }
        }
    }

    
    func reset() {
        self.latitude = 0.0
        self.longitude = 0.0
        self.isLocationFound = false
    }
    
}

#Preview {
    ChooseLocate()
}
