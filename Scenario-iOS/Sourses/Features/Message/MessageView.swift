//
//  MessageView.swift
//  Scenario
//
//  Created by dgsw07 on 3/6/25.
//

import SwiftUI

struct MessageView: View {
    @State var searchText = ""
    @State var seeMore = false
    @State var next = false
    var body: some View {
        SharedContentView(
            seeMore: $seeMore,
            searchText: $searchText,
            title: "메시지",
            addButtonText: "연락처 추가하기",
            contactCardHeight: 499,
            showPicker: true) {
                next = true
            }
            .navigationDestination(isPresented: $next) {
                EmptyView()
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
