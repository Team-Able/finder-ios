//
//  Header.swift
//  Finder
//
//  Created by dgsw30 on 10/16/24.
//

import SwiftUI

struct Header: View {
    @StateObject private var myVM = MyViewModel()
    var body: some View {
        HStack {
            Image(.logo)
                .resizable()
                .frame(width: 150, height: 52)
            Spacer()
            NavigationLink {
                MyView()
            } label: {
                if let imageUrl = URL(string:myVM.profileImageUrl) {
                    AsyncImage(url: imageUrl) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 40, height: 40)
                    } placeholder: {
                        Rectangle()
                            .fill(Color.init(uiColor: .systemGray2))
                            .frame(width: 40, height: 40)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 50))
                }
            }
            .padding()
        }
        .padding(.horizontal, 8)
        .onAppear {
            myVM.fetchMy()
        }
    }
}

#Preview {
    Header()
}
