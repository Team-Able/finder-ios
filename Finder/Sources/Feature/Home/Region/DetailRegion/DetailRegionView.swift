//
//  DetailRegion.swift
//  Finder
//
//  Created by dgsw30 on 12/15/24.
//

import SwiftUI

struct DetailRegionView: View {
    @StateObject private var Username = MyViewModel()
    @StateObject private var viewModel = LostItemViewModel()
    @StateObject private var detailVM = DetailViewModel()
    @State private var toDetail = false
    var body: some View {
        VStack {
            HStack {
                Text("\(Username.username)님 주변 분실물 이에요!")
                    .font(.bold(24))
                Spacer()
            }
            .padding()
            ScrollView {
                ForEach(viewModel.items, id: \.id) { region in
                    RegionComponentView(regionVM: region) {
                        detailVM.detailPost(id: region.id)
                        toDetail = true
                    }
                }
            }
        }
        .backButton()
        .navigationDestination(isPresented: $toDetail) {
            if let detailPost = detailVM.detailItems {
                DetailPostView(getPost: detailPost)
            }
        }
        .onAppear {
            viewModel.fetchItems()
            Username.fetchMy()
        }
        .refreshable {
            viewModel.fetchItems()
        }
    }
}

#Preview {
    DetailRegionView()
}
