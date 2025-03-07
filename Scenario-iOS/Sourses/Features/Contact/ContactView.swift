//
//  ContactView.swift
//  Scenario
//
//  Created by dgsw07 on 3/6/25.
//

import SwiftUI

struct ContactView: View {
    @State var next = false
    @State var searchText = ""
    @State var seeMore = false
    
    var body: some View {
        SharedContentView(
            seeMore: $seeMore,
            searchText: $searchText,
            title: "연락처",
            addButtonText: "연락처 추가하기",
            contactCardHeight: 499,
            showPicker: false) {
                next = true
            }
            .navigationDestination(isPresented: $next) {
                EmptyView()
            }
    }
}


#Preview {
    ContactView()
}
