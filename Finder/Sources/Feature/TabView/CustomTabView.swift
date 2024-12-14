//
//  MainView.swift
//  Finder
//
//  Created by dgsw30 on 10/10/24.
//
import SwiftUI

struct CustomTabView: View {
    @State private var selectedTab: TabViewType = .home
    @StateObject private var keyboardResponder = KeyboardResponder()

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ZStack {
                    switch selectedTab {
                    case .search: SearchView()
                    case .home: HomeView()
                    case .write: WriteView()
                    }
                }
                
                if keyboardResponder.keyboardHeight == 0 {
                    HStack {
                        ForEach(TabViewType.allCases, id: \.self) { tab in
                            Button(action: {
                                selectedTab = tab
                            }) {
                                VStack {
                                    Spacer()
                                    TabViewCell(type: tab, isSelected: selectedTab == tab)
                                }
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(.horizontal, 20)
                    .frame(height: 95)
                }
            }
        }
        .padding(.bottom, 4)
    }
}
