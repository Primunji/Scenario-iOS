//
//  SharedContentView.swift
//  Scenario
//
//  Created by dgsw07 on 3/5/25.
//

import SwiftUI

import SwiftUI

struct SharedContentView: View {
    @Binding var seeMore: Bool
    @Binding var searchText: String
    let title: String
    let addButtonText: String
    let contactCardHeight: CGFloat
    let showPicker: Bool
    let addAction: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.05)
                .ignoresSafeArea()
            VStack(spacing: 0) {
                HStack {
                    Image("Logo")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(.top, 39)
                    Text(title)
                        .font(.pretendard(.semibold, size: 36))
                        .padding(.bottom, 10)
                        .padding(.top, 50)
                    Spacer()
                }
                
                CustomSearchField(searchText: $searchText)
                
                if showPicker {
                    RecentCard()
                } else {
                    ContactCard(title: "연락처")
                }
                
                AddButton(text: addButtonText, action: addAction) 
                    .offset(y: -30)
            }
            .padding(.horizontal, 16)
        }
    }
}


#Preview {
    ContactView()
}

#Preview {
    RecentCallView()
}
