//
//  SearchView.swift
//  Finder
//
//  Created by dgsw30 on 10/10/24.
//

import SwiftUI

struct SearchView: View {
    @StateObject var myVM = MyViewModel()
    @StateObject var viewModel = LostItemViewModel()
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Header()
                ScrollView {
                    LazyVStack(alignment: .leading,spacing: 30) {
                        Text("\(myVM.username)님 주변 분실물이에요!")
                            .font(.system(size: 24).weight(.semibold))
                            
                        ForEach(viewModel.items) { item in
                            NavigationLink {
                                EmptyView()
                            } label: {
                                HStack {
                                    AsyncImage(url:URL(string: item.imageUrl)) { image in
                                        image.image?.resizable()
                                            .frame(width: 110,height: 110)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                    }
                                
                                
                                VStack(alignment:.leading) {
                                    Text(item.title)
                                        .font(.system(size: 16).weight(.semibold))
                                        
                                        .padding(.bottom,10)
                                    Text(item.content)
                                        .lineLimit(1)
                                        .frame(width: 140)
                                        .font(.system(size: 12).weight(.regular))
                                    HStack {
                                        Text(item.createdAt)
                                                .font(.system(size: 12).weight(.regular))
                                                .lineLimit(1)
                                            Spacer().frame(width: 40)
                                        Label {
                                            Text("\(item.id)")
                                                .font(.system(size: 12).weight(.regular))
                                        } icon: {
                                            Image(systemName: "bubble.right")
                                                .font(.system(size: 12).weight(.regular))
                                                .foregroundColor(.primary800)
                                        }
                                        }
                                    .foregroundColor(.secondary.opacity(0.7))
                                    .padding(.top,10)

                                    }
                                }
                                .foregroundColor(.black)
                            }
                        }
                    }
                    .padding(.leading,15)
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
