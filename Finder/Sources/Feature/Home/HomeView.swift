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
                        RegionView()
                        LatestView()
                    }
                }
            }
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    HomeView()
}
