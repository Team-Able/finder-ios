//
//  SearchPickerView.swift
//  Finder
//
//  Created by dgsw07 on 10/30/24.
//

import SwiftUI
import Kingfisher


struct SearchView: View {
    @StateObject private var defaultVM = LostItemViewModel()
    @StateObject private var searchVM = SearchViewModel()
    @State private var pickerOn = false
    @State private var searchText = ""
    @State private var editText = false
    @State private var isSearching = false
    
    var body: some View {
        ZStack {
            NavigationStack {
                VStack(alignment: .leading) {
                    HStack {
                        //                        Button {
                        //                            pickerOn = true
                        //                        } label: {
                        Text("분실물 검색")
                            .font(.system(size: 20).weight(.medium))
                        //                            HStack {
                        //                                Text("달성군")
                        //                                    .font(.system(size: 20).weight(.medium))
                        //
                        //                                Image(systemName: "chevron.down")
                        //                                    .font(.system(size: 20).weight(.regular))
                        //                            }
                        //                        }
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
                    .padding(.leading,24)
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
                                    SearchComponent(viewModel: item)
                                }
                            } else {
                                ForEach(defaultVM.items, id:\.id) { item in
                                    SearchDefaultComponnent(viewModel: item)
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
        }
        //        .overlay {
        //            if pickerOn {
        //                VStack {
        //                    CustomPicker()
        //                        .overlay {
        //                            VStack {
        //                                Rectangle()
        //                                    .frame(width: 370,height: 225)
        //                                Spacer()
        //                                Rectangle()
        //                                    .frame(width: 370,height: 250)
        //                            }
        //                            .foregroundColor(.secondary.opacity(0.01))
        //                            .onTapGesture {
        //                                pickerOn = false
        //                            }
        //                        }
        //                }
        //            }
        //        }
        .refreshable {
            defaultVM.fetchItems()
        }
    }
}

#Preview {
    SearchView()
}

