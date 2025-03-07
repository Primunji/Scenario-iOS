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
        SharedContentView(
            seeMore: $seeMore,
            searchText: $searchText,
            title: "내역",
            addButtonText: "내역 더보기",
            contactCardHeight: 455,
            showPicker: true) {
                next = true
            }
    }
}
#Preview {
    RecentCallView()
}


enum RecentCallTabs: String, CaseIterable {
    case all = "전체"
    case success = "성공"
    case fail = "실패"
}
