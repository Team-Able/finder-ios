//
//  BackButton.swift
//  Finder
//
//  Created by dgsw30 on 10/8/24.
//

import SwiftUI

struct BackButton: ViewModifier {
    @Environment(\.dismiss) var dismiss
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden()
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

extension View {
    public func backButton() -> some View {
        modifier(BackButton())
    }
}
