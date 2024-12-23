//
//  LatestComponentView.swift
//  Finder
//
//  Created by dgsw30 on 12/15/24.
//

import SwiftUI

struct LatestComponentView: View {
    let latestVM: LatestPostModel
    let action: () -> Void
    
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 30) {
            Button {
                action()
            } label: {
                HStack {
                    let imageUrl = URL(string: latestVM.imageUrl)
                    AsyncImage(url: imageUrl) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 110, height: 110)
                            .cornerRadius(8)
                    } placeholder: {
                        Rectangle()
                            .fill(Color.init(uiColor: .systemGray2))
                            .frame(width: 110, height: 110)
                    }
                    
                    VStack(alignment:.leading) {
                        Text(latestVM.title)
                            .font(.system(size: 16).weight(.semibold))
                            .padding(.bottom,10)
                        Text(latestVM.content)
                            .font(.system(size: 12).weight(.regular))
                        HStack {
                            Text(latestVM.createdAt)
                                .font(.system(size: 12).weight(.regular))
                            Spacer().frame(width: 40)
                            
                            Image(systemName: "bubble.right")
                                .font(.system(size: 12).weight(.regular))
                                .foregroundColor(.primary800)
                        }
                        .foregroundColor(.secondary.opacity(0.7))
                        .padding(.top, 10)
                    }
                }
                .foregroundColor(.black)
            }
        }
        .padding(.bottom, 14)
        .padding(.leading, 15)
    }
}
