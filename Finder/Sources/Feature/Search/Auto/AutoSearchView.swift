//
//  AutoSearchView.swift
//  Finder
//
//  Created by dgsw30 on 12/18/24.
//

import SwiftUI

struct AutoSearchView: View {
    let text: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Rectangle()
                .fill(Color.init(uiColor: .systemGray5))
                .frame(width: 410, height: 40)
                .overlay {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.black)
                            .padding(.trailing, 10)
                        Text(text)
                            .foregroundStyle(.black)
                        Spacer()
                    }
                    .padding()
                }
        }
        .buttonStyle(PlainButtonStyle())
    }
}
