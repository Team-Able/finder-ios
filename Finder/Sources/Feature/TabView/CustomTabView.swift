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
                
                Spacer()
                
                if keyboardResponder.keyboardHeight == 0 {
                    GeometryReader { geometry in
                        HStack(spacing: 0) {
                            ForEach(TabViewType.allCases, id: \.self) { tab in
                                Button(action: {
                                    selectedTab = tab
                                }) {
                                    HStack {
                                        TabViewCell(type: tab, isSelected: selectedTab == tab)
                                    }
                                }
                                .frame(maxWidth: .infinity)
                            }
                        }
                        .frame(height: 85)
                        .background(Color.white)
                        .offset(y: geometry.safeAreaInsets.bottom)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color.white)
                    .shadow(radius: 0.3)
                    .ignoresSafeArea(edges: .bottom)
                }
            }
            .padding(.bottom, 13)
        }
    }
}

#Preview {
    CustomTabView()
}
