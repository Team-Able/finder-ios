//
//  LostItemPost.swift
//  Finder
//
//  Created by dgsw30 on 12/13/24.
//

import SwiftUI

struct LatestItemPost: View {
    let viewModel: LatestPostModel
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            RoundedRectangle(cornerRadius: 14)
                .foregroundColor(.secondary.opacity(0.3))
                .frame(width: 135, height: 160)
                .shadow(color: .gray.opacity(0.5), radius: 1, y: 4)
                .overlay {
                    MapView(
                        latitude: Binding(get: { viewModel.location.latitude }, set: { _ in }),
                        longitude: Binding(get: { viewModel.location.longitude }, set: { _ in }),
                        initialLatitude: viewModel.location.latitude,
                        initialLongitude: viewModel.location.longitude
                    )
                    .disabled(true)
                    .clipShape(RoundedRectangle(cornerRadius: 13))
                    .offset(y: -30)
                }
                .overlay {
                    Rectangle()
                        .frame(width: 135, height: 53)
                        .padding(.top, 107)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                        .foregroundColor(.white)
                        .overlay {
                            Text(viewModel.title)
                                .font(.system(size: 12).weight(.medium))
                                .padding(.top, 100)
                        }
                }
        }
        .foregroundColor(.black)
    }
}

