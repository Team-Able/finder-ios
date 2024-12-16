//
//  SearchComponent.swift
//  Finder
//
//  Created by dgsw30 on 12/16/24.
//

import SwiftUI
import Kingfisher

struct SearchDefaultComponnent: View {
    let viewModel: ItemInfo
    
    var body: some View {
        NavigationLink {
            EmptyView()
        } label: {
            HStack {
                let imageUrl = URL(string: viewModel.imageUrl)
                KFImage(imageUrl)
                    .placeholder { _ in
                        Rectangle()
                            .fill(Color.init(uiColor: .systemGray2))
                            .frame(width: 110, height: 110)
                    }
                    .resizable()
                    .frame(width: 110, height: 110)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                
                VStack(alignment:.leading) {
                    Text(viewModel.title)
                        .font(.bold(16))
                        .padding(.bottom,10)
                    Text(viewModel.content)
                        .font(.regular(12))
                    HStack {
                        Text(viewModel.createdAt)
                            .font(.light(12))
                        Spacer().frame(width: 40)
                        Label {
                            Text("\(viewModel.id)")
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
                .padding(.leading, 10)
            }
            .foregroundColor(.black)
        }
    }
}
