//
//  MainView.swift
//  Finder
//
//  Created by dgsw30 on 10/10/24.
//
//MARK: 이거 도담 코드보고 수정
import SwiftUI

struct CustomTabView: View {
    @State private var selectedtab: TabViewType = .home
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                ZStack {
                    switch selectedtab {
                    case .search:
                        SearchView()
                    case .home:
                        HomeView()
                    case .write:
                        WriteView()
                    }
                }
            }
            
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    Spacer()
                        .frame(width: geometry.size.width, height: 97)
                        .overlay(
                            HStack {
                                ForEach(TabViewType.allCases, id: \.self) { tab in
                                    Button(action: {
                                        selectedtab = tab
                                    }
                                    ) {
                                        VStack {
                                            Spacer()
                                            TabViewCell(type: tab, isSelected: selectedtab == tab)
                                        }
                                    }
                                    .frame(maxWidth: .infinity)
                                }
                            }
                                .padding(.horizontal, 20)
                        )
                }
            }
        }
    }
}

#Preview {
    CustomTabView()
        .environmentObject(LoginViewModel())
}
