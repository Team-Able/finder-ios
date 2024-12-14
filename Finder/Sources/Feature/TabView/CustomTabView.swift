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
                    case .search: SearchPickerView()
                    case .home: HomeView()
                    case .write: WriteView()
                    }
                }
                
                Spacer()
                
                if keyboardResponder.keyboardHeight == 0 {
                    GeometryReader { geometry in
                        HStack {
                            ForEach(TabViewType.allCases, id: \.self) { tab in
                                Button(action: {
                                    selectedTab = tab
                                }) {
                                    VStack {
                                        TabViewCell(type: tab, isSelected: selectedTab == tab)
                                    }
                                }
                                .frame(maxWidth: .infinity)
                            }
                        }
                        .frame(width: geometry.size.width)
                        .background(Color.white)
                        .frame(height: 85)
                        .offset(y: geometry.safeAreaInsets.bottom)
                    }
                    .padding(.horizontal, 20)
                    .frame(height: 55)
                    .background(Color.white)
                    .ignoresSafeArea(edges: .bottom)
                }
            }
            .padding(.bottom, 13)
        }
    }
}
