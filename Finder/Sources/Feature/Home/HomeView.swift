import SwiftUI
import Combine
import MapKit

struct HomeView: View {
    @StateObject var viewModel = LostItemViewModel()
    @State private var toDetail = false
    
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
                                    LostItemPost(viewModel: item) {
                                        toDetail = true
                                    }
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
        .navigationDestination(isPresented: $toDetail) {
            DetailPostView()
        }
    }
}

#Preview {
    HomeView()
}
