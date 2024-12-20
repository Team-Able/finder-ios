//
//  DetailLatestView.swift
//  Finder
//
//  Created by dgsw30 on 12/15/24.
//

import SwiftUI

struct DetailLatestView: View {
    @StateObject private var latestVM = LostItemViewModel()
    @StateObject private var detailVM = DetailViewModel()
    @State private var toDetail = false
    var body: some View {
        VStack {
            HStack {
                Text("최근 등록된 분실물 이에요!")
                    .font(.bold(24))
                Spacer()
            }
            .padding()
            ScrollView {
                ForEach(latestVM.latestItems, id: \.id) { latestPost in
                    LatestComponentView(latestVM: latestPost) {
                        detailVM.detailPost(id: latestPost.id)
                        toDetail = true
                    }
                }
            }
        }
        .backButton()
        .onAppear {
            latestVM.getLatestItems()
        }
        .navigationDestination(isPresented: $toDetail) {
            if let detailPost = detailVM.detailItems {
                DetailPostView(getPost: detailPost)
            }
        }
        .refreshable {
            latestVM.getLatestItems()
        }
    }
}

#Preview {
    DetailLatestView()
}
