//
//  SearchView.swift
//  Finder
//
//  Created by dgsw30 on 10/10/24.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var myVM = MyViewModel()
    @StateObject var viewModel = LostItemViewModel()
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Header()
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        Text("\(myVM.username)OOO님 주변 분실물이에요!")
                            .font(.system(size: 24).weight(.semibold))
                            
                        ForEach(viewModel.items) { item in
                            NavigationLink {
                                EmptyView()
                            } label: {
                                HStack {
                                    Rectangle()
                                        .frame(width: 110,height: 110)
                                        .foregroundColor(.secondary.opacity(0.4))
                                        .padding(.bottom,20)
                                        .overlay {
                                            AsyncImage(url:URL(string: item.imageUrl)) { image in
                                                image.image?.resizable()
                                                    .frame(width: 110,height: 110)
                                            }
                                        }
                                    VStack(alignment:.leading) {
                                        Text(item.title)
                                            .font(.system(size: 16).weight(.semibold))
                                        Text(item.content)
                                        HStack {
                                            Text(item.createdAt)
                                                .font(.system(size: 12).weight(.regular))
                                            Spacer().frame(width: 40)
                                            Text("\(item.id)")
                                                .font(.system(size: 12).weight(.regular))

                                        }
                                    }
                                }
                                .foregroundColor(.black)
                            }
                        }
                    }
                    .padding(.leading,25)
                }
            }
            Spacer()
                .navigationBarBackButtonHidden()
        }
        .onAppear {
            viewModel.fetchItems()
        }
    }
}

#Preview {
    SearchView()
}
