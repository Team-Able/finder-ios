//
//  SortPickerView.swift
//  Finder
//
//  Created by dgsw07 on 10/30/24.
//

import SwiftUI

struct SortPickerView: View {
    @StateObject var viewModel = LostItemViewModel()
    @ObservedObject var myVM = MyViewModel()
    @State var pickerOn = false
    @State var searchText = ""
    @State var editText = false
    @State var sortPickerOn = false
    var body: some View {
        ZStack {
            NavigationStack {
                VStack(alignment: .leading) {
                    HStack {
                        Spacer().frame(width: 50)
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1.0)
                            .frame(width: 243,height: 40)
                            .foregroundColor(.primary500)
                            .overlay {
                                HStack {
                                    TextField("분실물을 검색해 주세요.",text: $searchText)
                                        .autocapitalization(.none)
                                        .font(.system(size: 16).weight(.regular))
                                        .onChange(of: searchText) { text in
                                            withAnimation(.easeInOut(duration: 0.1)) {
                                                editText = !text.isEmpty
                                            }
                                        }
                                    if editText {
                                        Button  {
                                            withAnimation(.easeInOut(duration: 0.1)) {
                                                self.searchText = ""
                                            }
                                        } label: {
                                            Image(systemName: "xmark.circle.fill")
                                                .foregroundColor(.primary500)
                                    }
                                    } else {
                                        Image(systemName: "magnifyingglass")
                                            .foregroundColor(.primary500)
                                    }
                                        
                                    
                                }
                                .padding(.horizontal,10)
                            }
                    }
                    .frame(height: 80)
                    .padding(.leading,24)
                    ScrollView {
                        LazyVStack(alignment: .leading,spacing: 30) {
                            ForEach(viewModel.items) { item in
                                NavigationLink {
                                    EmptyView()
                                } label: {
                                    HStack {
                                        AsyncImage(url:URL(string: item.imageUrl)) { image in
                                            image.image?.resizable()
                                                .frame(width: 110,height: 110)
                                        }
                                        
                                        
                                        VStack(alignment:.leading) {
                                            Text(item.title)
                                                .font(.system(size: 16).weight(.semibold))
                                                .padding(.bottom,10)
                                            Text(item.content)
                                                .font(.system(size: 12).weight(.regular))
                                            HStack {
                                                Text(item.createdAt)
                                                    .font(.system(size: 12).weight(.regular))
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
        .overlay {
            if pickerOn {
                VStack {
                    CustomPicker()
                        .overlay {
                            VStack {
                                Rectangle()
                                    .frame(width: 370,height: 225)
                                Spacer()
                                Rectangle()
                                    .frame(width: 370,height: 250)
                            }
                            .foregroundColor(.secondary.opacity(0.01))
                            .onTapGesture {
                                pickerOn = false
                            }
                        }
                }
            }
            
        }

    }
}

#Preview {
    SortPickerView()
}

