//
//  MessageView.swift
//  Scenario
//
//  Created by dgsw07 on 3/6/25.
//

import SwiftUI

struct MessageView: View {
    @State var next = false
    @State var searchText = ""
    @State var seeMore = false
    
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
                    Text("연락처")
                        .font(.pretendard(.semibold, size: 36))
                        .padding(.bottom, 10)
                        .padding(.top, 50)
                    Spacer()
                }
                
                CustomSearchField(placeholder: "검색하기",searchText: $searchText)
                
                MessageCard(height: 499)
                
                
                AddButton(text: "addButtonText") {
                    print("dd")
                }
                .offset(y: 10)
            }
            .padding(.horizontal, 16)
            
        }
    }
}


#Preview {
    MessageView()
}


//
//struct ContactView: View {
//    @State var searchText = ""
//    @State var seeMore = false
//    
//    var body: some View {
//        SharedContentView(
//            seeMore: $seeMore,
//            searchText: $searchText,
//            title: "연락처",
//            addButtonText: "연락처 추가하기",
//            contactCardHeight: 499,
//            showPicker: false
//        )
//    }
//}
//
//
//#Preview {
//    ContactView()
//}
