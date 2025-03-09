//
//  RecentCallView.swift
//  Scenario
//
//  Created by dgsw07 on 3/6/25.
//

import SwiftUI

struct RecentCallView: View {
    @State var next = false
    @State var searchText = ""
    @State private var seeMore = false
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.05)
                .ignoresSafeArea()
            VStack(spacing: 0) {
                HStack {
                    Image("Logo")
                        .resizable()
                        .frame(width: 30, height: 30)
                    Text("최근 통화")
                        .font(.pretendard(.semibold, size: 36))
                        .padding(.bottom, 10)
                        .padding(.top, 11)
                    Spacer()
                }
                
                CustomSearchField(placeholder: "검색하기",searchText: $searchText)
                
                RecentCard(viewModel: ScenarioViewModel(), height: 499)
                
                
                AddButton(text: "내역 더보기") {
                    print("dd")
                }
                .padding(.bottom, 17)
            }
            .padding(.horizontal, 16)
        }
        
    }
}
    

#Preview {
    RecentCallView()
}

