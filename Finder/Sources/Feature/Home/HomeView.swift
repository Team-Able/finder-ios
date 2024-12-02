import SwiftUI
import Alamofire
import Combine
import MapKit

struct HomeView: View {
    @StateObject var viewModel = LostItemViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Header()
                ScrollView {
                    VStack {
                        BannerView()
                            .shadow(color: .gray.opacity(0.2), radius: 3, y: 4)
                        HStack {
                            Text("내 주변 분실물 찾기")
                                .font(.system(size: 20).weight(.medium))
                            Spacer().frame(width: 160)
                            NavigationLink {
                                EmptyView()
                            } label: {
                                Text("자세히")
                                    .font(.system(size: 15).weight(.regular))
                            }
                        }
                        .padding(.top, 10)
                        
                        ScrollView(.horizontal) {
                            LazyHStack(spacing: 15) {
                                ForEach(viewModel.items) { item in
                                    NavigationLink {
                                        EmptyView()
                                    } label: {
                                        RoundedRectangle(cornerRadius: 14)
                                            .foregroundColor(.secondary.opacity(0.3))
                                            .frame(width: 135, height: 160)
                                            .shadow(color: .gray.opacity(0.5), radius: 1, y: 4)
                                            .overlay {
                                                MapView(
                                                    latitude: Binding(get: { item.location.latitude }, set: { _ in }),
                                                    longitude: Binding(get: { item.location.longitude }, set: { _ in }),
                                                    initialLatitude: item.location.latitude,
                                                    initialLongitude: item.location.longitude
                                                 )
                                                .disabled(true)
                                                .clipShape(RoundedRectangle(cornerRadius: 13))
                                                .offset(y: -30)
                                            }
                                            .overlay {
                                                Rectangle()
                                                    .frame(width: 135, height: 53)
                                                    .padding(.top, 107)
                                                    .clipShape(RoundedRectangle(cornerRadius: 14))
                                                    .foregroundColor(.white)
                                                    .overlay {
                                                        Text(item.title)
                                                            .font(.system(size: 12).weight(.medium))
                                                            .padding(.top, 100)
                                                    }
                                            }
                                    }
                                    .foregroundColor(.black)
                                }
                            }
                            .padding(.leading, 10)
                            .offset(y: 15)
                            .frame(height: 200)
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden()
        }
        .onAppear {
            viewModel.fetchItems()
        }
    }
}

#Preview {
    HomeView()
}
