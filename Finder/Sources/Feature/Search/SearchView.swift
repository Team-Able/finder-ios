//
//  SearchPickerView.swift
//  Finder
//
//  Created by dgsw07 on 10/30/24.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var defaultVM = LostItemViewModel() //MARK: 기본 게시물 불러오기
    @StateObject private var searchVM = SearchViewModel() //MARK: 검색 게시물 불러오기
    @StateObject private var detailVM = DetailViewModel() //MARK: 게시글 자세히 보기
    
    @State private var searchText = ""
    @State private var editText = false
    @State private var isSearching = false
    @State private var defaultDetail = false
    @State private var searchDetail = false
    
    var body: some View {
        ZStack {
            NavigationStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text("분실물 검색")
                            .font(.system(size: 20).weight(.medium))
                            .foregroundColor(.black)
                            .padding(.trailing, 15)
                        
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1.0)
                            .frame(width: 243, height: 40)
                            .foregroundColor(.primary500)
                            .overlay {
                                HStack {
                                    Button  {
                                        searchVM.search(search: searchText)
                                        isSearching = true
                                    } label: {
                                        Image(systemName: "magnifyingglass")
                                            .foregroundColor(.primary500)
                                    }
                                    TextField("분실물을 검색해 주세요.",text: $searchText)
                                        .autocapitalization(.none)
                                        .tint(.primary500)
                                        .font(.system(size: 16).weight(.regular))
                                        .onChange(of: searchText) { text in
                                            withAnimation(.easeInOut(duration: 0.1)) {
                                                editText = !text.isEmpty
                                            }
                                        }
                                    if editText {
                                        Button {
                                            withAnimation(.easeInOut(duration: 0.1)) {
                                                self.searchText = ""
                                            }
                                        } label: {
                                            Image(systemName: "xmark.circle.fill")
                                                .foregroundColor(.primary500)
                                        }
                                    }
                                }
                                .onSubmit {
                                    searchVM.search(search: searchText)
                                    isSearching = true
                                }
                                .hideKeyBoard()
                                .padding(.horizontal, 10)
                            }
                    }
                    .frame(height: 80)
                    .padding(.leading, 24)
                    
                    VStack {
                        if !searchVM.autoSearchItem.isEmpty {
                            VStack(spacing: 0) {
                                HStack {
                                    Text("추천 검색어")
                                        .font(.regular(15))
                                    Spacer()
                                }
                                .padding(.leading, 14)
                                .padding(.vertical, 4)
                                ForEach(searchVM.autoSearchItem, id:\.self) { item in
                                    AutoSearchView(text: item) {
                                        searchVM.search(search: item)
                                        isSearching = true
                                    }
                                }
                            }
                            .padding(.top, -14)
                            .padding(.leading, 4)
                        }
                    }
                    
                    ScrollView {
                        if searchVM.itemisEmpty {
                            VStack {
                                Text("검색결과가 없어요!")
                                    .font(.medium(16))
                                    .padding(.top, 30)
                            }
                        }
                        LazyVStack(alignment: .leading,spacing: 30) {
                            if isSearching {
                                ForEach(searchVM.searchItem, id: \.id) { item in
                                    SearchComponent(viewModel: item) {
                                        detailVM.detailPost(id: item.id)
                                        searchDetail = true
                                    }
                                }
                            } else {
                                ForEach(defaultVM.items, id:\.id) { item in
                                    SearchDefaultComponnent(viewModel: item) {
                                        detailVM.detailPost(id: item.id)
                                        defaultDetail = true
                                    }
                                }
                            }
                        }
                        .padding(.leading, 15)
                    }
                }
                Spacer()
                    .navigationBarBackButtonHidden()
            }
            .onAppear {
                defaultVM.fetchItems()
            }
            .navigationDestination(isPresented: $searchDetail) {
                if let detailPost = detailVM.detailItems {
                    DetailPostView(getPost: detailPost)
                }
            }
            .navigationDestination(isPresented: $defaultDetail) {
                if let defaultDetailPost = detailVM.detailItems {
                    DetailPostView(getPost: defaultDetailPost)
                }
            }
            .onChange(of: searchText) { oldValue in
                searchVM.autoSearch(search: searchText)
            }
        }
        .refreshable {
            isSearching = false
            searchVM.itemisEmpty = false
            defaultVM.fetchItems()
        }
    }
}

#Preview {
    SearchView()
}

