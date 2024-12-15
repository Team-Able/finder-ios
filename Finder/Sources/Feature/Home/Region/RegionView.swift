//
//  RegionView.swift
//  Finder
//
//  Created by dgsw30 on 12/14/24.
//

import SwiftUI

struct RegionView: View {
    @StateObject var viewModel = LostItemViewModel()
    @State private var toDetail = false
    var body: some View {
        HStack {
            Text("내 주변 분실물 찾기")
                .font(.system(size: 20).weight(.medium))
            Spacer().frame(width: 160)
            NavigationLink {
                DetailRegionView()
            } label: {
                Text("자세히")
                    .font(.system(size: 15).weight(.regular))
            }
        }
        .padding(.top, 10)
        
        ScrollView(.horizontal) {
            LazyHStack(spacing: 15) {
                ForEach(viewModel.items, id: \.id) { item in
                    LostItemPost(viewModel: item) {
                        viewModel.detailPost(id: item.id)
                        toDetail = true
                    }
                }
            }
            .padding(.leading, 10)
            .offset(y: 15)
            .frame(height: 200)
        }
        .onAppear {
            viewModel.fetchItems()
        }
        .navigationDestination(isPresented: $toDetail) {
            if let detailPost = viewModel.detailItems {
                DetailPostView(getPost: detailPost)
            }
        }
    }
}

#Preview {
    RegionView()
}
