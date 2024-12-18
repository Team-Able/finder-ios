//
//  LatestView.swift
//  Finder
//
//  Created by dgsw30 on 12/14/24.
//

import SwiftUI

struct LatestView: View {
    @StateObject var viewModel = LostItemViewModel()
    @StateObject private var detailVM = DetailViewModel()
    @State private var toDetail = false
    var body: some View {
        HStack {
            Text("최근 등록된 분실물 찾기")
                .font(.system(size: 20).weight(.medium))
            Spacer()
                .frame(width: 130)
            NavigationLink {
                DetailLatestView()
            } label: {
                Text("자세히")
                    .font(.system(size: 15).weight(.regular))
            }
        }
        .padding(.top, 10)
        
        ScrollView(.horizontal) {
            LazyHStack(spacing: 15) {
                ForEach(viewModel.latestItems, id: \.id) { item in
                    LatestItemPost(viewModel: item) {
                        detailVM.detailPost(id: item.id)
                        toDetail = true
                    }
                }
            }
            .padding(.leading, 10)
            .offset(y: 15)
            .frame(height: 200)
        }
        .onAppear {
            viewModel.getLatestItems()
        }
        .navigationDestination(isPresented: $toDetail) {
            if let detailPost = detailVM.detailItems {
                DetailPostView(getPost: detailPost)
            }
        }
    }
}

#Preview {
    LatestView()
}
