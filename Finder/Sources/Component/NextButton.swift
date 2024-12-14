//
//  NextButton.swift
//  Finder
//
//  Created by dgsw30 on 10/8/24.
//

import SwiftUI

struct NextButton<Destination: View>: View {
    let destination: Destination
    let isEnabled: Bool
    var body: some View {
        NavigationLink(destination: destination) {
            Text("다음")
                .font(.bold(22))
                .foregroundColor(.white)
                .frame(width: 330, height: 60)
                .background(isEnabled ? .primary500 : Color.init(uiColor: .systemGray4))
                .cornerRadius(13)
                .padding(15)
        }
        .disabled(!isEnabled)
    }
}
