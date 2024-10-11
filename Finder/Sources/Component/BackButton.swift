//
//  BackButton.swift
//  Finder
//
//  Created by dgsw30 on 10/8/24.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        HStack {
            EmptyView()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .bold()
                    }
                }
            }
        }
    }
}
