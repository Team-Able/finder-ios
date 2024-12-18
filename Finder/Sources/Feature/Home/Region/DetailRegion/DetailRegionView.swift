//
//  DetailRegion.swift
//  Finder
//
//  Created by dgsw30 on 12/15/24.
//

import SwiftUI

struct DetailRegionView: View {
    @StateObject private var Username = MyViewModel()
    var body: some View {
        VStack {
            HStack {
                Text("\(Username.username)님 주변 분실물 이에요!")
                    .font(.bold(24))
                Spacer()
            }
            .padding()
        }
        .onAppear {
            Username.fetchMy()
        }
    }
}

#Preview {
    DetailRegionView()
}
