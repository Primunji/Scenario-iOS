//
//  MainTabView.swift
//  Scenario-iOS
//
//  Created by dgsw07 on 3/8/25.
//


import SwiftUI

struct MainTabView: View {
    @State var selectedTab : TabbedItems = .contact
    var body: some View {
        VStack(spacing: 0 ) {
            ZStack {
                ContactView()
                    .opacity(selectedTab == .contact ? 1 : 0)
                RecentCallView()
                    .opacity(selectedTab == .recentCall ? 1 : 0)
                MessageView()
                    .opacity(selectedTab == .message ? 1 : 0)
                CreateView()
                    .opacity(selectedTab == .scenario ? 1 : 0)
            }
            HStack {
                ForEach(TabbedItems.allCases, id: \.self) { tab in
                    Button {
                        selectedTab = tab
                    } label: {
                        VStack {
                            
                            TabViewCell(type: tab, isSelected: selectedTab == tab)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal, 10)
            .frame(height: 101)
            .background {
                Rectangle()
                    .stroke(lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.black.opacity(0.1))
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        
    }
}

#Preview {
    MainTabView()
}
