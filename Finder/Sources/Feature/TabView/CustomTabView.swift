//
//  MainView.swift
//  Finder
//
//  Created by dgsw30 on 10/10/24.
//
//MARK: 이거 도담 코드보고 수정
import SwiftUI

struct CustomTabView: View {
    @State private var selectedTab: TabViewType = .home

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ZStack {
                    switch selectedTab {
                    case .search:
                        SearchView()
                    case .home:
                        HomeView()
                    case .write:
                        WriteView()
                    }
                }
                
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
        .padding(.bottom, 4)
    }
}

#Preview {
    CustomTabView()
        .environmentObject(LoginViewModel())
}
