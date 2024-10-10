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
        ScrollView(.horizontal) {
            HStack {
                ForEach(0..<3) { image in
                    Image(.banner)
                }
            }
        }
    }
}

#Preview {
    BannerView()
}
