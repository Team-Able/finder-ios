//
//  CustomPicker.swift
//  Finder
//
//  Created by dgsw07 on 10/30/24.
//

import SwiftUI

struct CustomPicker: View {
    @State var searchLocal = ""
    var local = ["대구광역시 수성구","대구광역시 달성군","대구광역시 북구","대구광역시 중구","대구광역시 달서구"]
    var body: some View {
        Color.secondary.opacity(0.4)
            .overlay {
                RoundedRectangle(cornerRadius: 14)
                    .frame(width: 272,height: 272)
                    .foregroundColor(.white.opacity(1))
                    .overlay {
                        VStack(alignment:.leading) {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.secondary,lineWidth: 0.4)
                                .frame(width: 250,height: 36)
                                .overlay {
                                    VStack {
                                        HStack {
                                            TextField("지역 검색하기",text: $searchLocal)
                                                .font(.system(size: 13).weight(.regular))
                                                .padding()
                                            Image(systemName: "magnifyingglass")
                                                .font(.system(size: 16).weight(.regular))
                                                .foregroundColor(.secondary.opacity(1))
                                                .padding()
                                        }
                                        
                                    }
                                }
                            ForEach(local,id:\.self) { locals in
                                VStack(alignment:.leading,spacing: 11) {
                                    Text(locals)
                                        .padding(.top,5)
                                        .font(.system(size: 15).weight(.regular))
                                    Rectangle().frame(width: 250,height: 0.6)
                                }
                                .foregroundColor(.secondary.opacity(0.9))
                            }
                        }
                    }
            }
            .ignoresSafeArea()
    }
}

#Preview {
    CustomPicker()
}
