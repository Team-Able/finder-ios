//
//  MainHomeView.swift
//  Finder
//
//  Created by dgsw30 on 10/10/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Header()
            ScrollView {
                VStack {
                    BannerView()
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    HomeView()
}
