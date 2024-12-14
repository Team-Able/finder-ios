//
//  SettingButton.swift
//  Finder
//
//  Created by dgsw30 on 10/12/24.
//

import SwiftUI

struct SettingButton: View {
    let text: String
    let action: () -> Void
    let color: Color
    
    
    var body: some View {
        Button {
            action()
        } label: {
            VStack {
                HStack {
                    Text(text)
                        .foregroundColor(color)
                        .font(.regular(17))
                        .padding()
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.black)
                        .padding()
                }
                .frame(width: 344,height: 50)
                .background(Color.white)
                .cornerRadius(8)
                .shadow(
                    color: Color(.sRGBLinear, white: 0, opacity: 0.1),
                    radius: 0.5, x: 0.5, y: 1
                )
            }
        }
    }
}
