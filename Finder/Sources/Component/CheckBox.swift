//
//  CheckBox.swift
//  Finder
//
//  Created by dgsw30 on 10/8/24.
//

import SwiftUI

struct CheckBox: View {
    @Environment(\.openURL) private var openURL
    let action: () -> Void
    let accept: Bool
    let text: String
    var body: some View {
        HStack {
            Button {
                action()
            } label: {
                Image(systemName: accept ? "checkmark.square.fill" : "square")
                    .resizable()
                    .frame(width: 18,height: 19)
                    .foregroundStyle(.primary500)
            }
            Button {
                if let url = URL(string: "https://ckwwy.notion.site/117c712ef99b8079a0b6f1070489b739?pvs=25") {
                    openURL(url)
                }
            } label: {
                Text(text)
                    .font(.custom("SF-Pro-Text-Regular", size: 16))
                    .foregroundStyle(Color.primary800)
                    .background(
                        Color.primary800
                            .frame(height: 1)
                            .offset(y: 14)
                    )
                Text("동의")
                    .font(.system(size: 16))
                    .foregroundStyle(.black)
            }
        }
    }
}
