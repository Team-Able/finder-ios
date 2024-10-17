//
//  Header.swift
//  Finder
//
//  Created by dgsw30 on 10/16/24.
//

import SwiftUI

struct Header: View {
    @State private var toSetting = false
    var body: some View {
        HStack {
            Image(.logo)
                .resizable()
                .frame(width: 150, height: 52)
            Spacer()
            Button(action: {
                toSetting = true
            }, label: {
                Image(.my)
            })
            .padding()
        }
        .padding(.horizontal, 8)
        .navigationDestination(isPresented: $toSetting) {
            MyView()
        }
    }
}

#Preview {
    Header()
}
