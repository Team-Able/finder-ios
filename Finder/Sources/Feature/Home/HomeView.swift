//
//  MainHomeView.swift
//  Finder
//
//  Created by dgsw30 on 10/10/24.
//

import SwiftUI

struct HomeView: View {
    @State private var toSetting = false
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Image(.logo)
                        .resizable()
                        .frame(width: 150,height: 52)
                    Spacer()
                    Button(action: {
                        toSetting = true
                    }, label: {
                        Image(.my)
                    })
                    .padding()
                }
                .padding()
                BannerView()
            }
        }
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $toSetting) {
            MyView()
        }
    }
}

#Preview {
    HomeView()
}
