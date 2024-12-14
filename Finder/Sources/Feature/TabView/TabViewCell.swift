//
//  TabView.swift
//  Finder
//
//  Created by dgsw30 on 10/10/24.
//

import SwiftUI

struct TabViewCell: View {
    
    let type: TabViewType
    let isSelected: Bool
    
    init(type: TabViewType, isSelected: Bool) {
        self.type = type
        self.isSelected = isSelected
    }
    
    var body: some View {
        VStack {
            ZStack {
                if isSelected {
                    Rectangle()
                        .fill(Color.primary600)
                        .frame(width: 52,height: 36)
                        .cornerRadius(4)
                }
                Image(isSelected ? type.click : type.image)
                    .resizable()
                    .frame(width: 28,height: 28)
                    .padding()
            }
            Text(type.text)
                .font(.regular(14))
                .foregroundStyle(.black)
        }
    }
}
