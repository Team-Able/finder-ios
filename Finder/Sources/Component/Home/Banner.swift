//
//  BannerView.swift
//  Finder
//
//  Created by dgsw30 on 10/10/24.
//
//MARK: 이거 수정
import SwiftUI

struct BannerView: View {
    var body: some View {
        TabView {
            ForEach(0..<3, id: \.self) { _ in
                Image(.banner)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .clipped()
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .frame(height: 180)
    }
}

#Preview {
    BannerView()
}
