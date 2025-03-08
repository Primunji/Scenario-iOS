//
//  VoiceSelectView.swift
//  Scenario-iOS
//
//  Created by dgsw07 on 3/8/25.
//

import SwiftUI

struct VoiceSelectView: View {
    @State var searchText = ""
    var body: some View {
        GeometryReader { scale in
            VStack(spacing:0) {
                HStack {
                    BackButton(text: "목소리 설정")
                    Spacer()
                }
                CustomSearchField(placeholder: "목소리 검색하기", searchText: $searchText)
            }
            .frame(width: scale.size.width, height: scale.size.height)
        }
    }
}

#Preview {
    VoiceSelectView()
}
