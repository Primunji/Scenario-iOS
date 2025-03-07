//
//  RecentCallPicker.swift
//  Scenario
//
//  Created by dgsw07 on 3/6/25.
//

import SwiftUI
import Foundation

enum RecentCallType: CaseIterable {
    case all
    case success
    case fail
    
    var text: String {
        switch self {
        case.all:
            return "전체"
        case.success:
            return "성공"
        case.fail:
            return "실패"
        }
    }
}


struct RecentCallCell: View {
    let type: RecentCallType
    let isSelected: Bool
    init(type: RecentCallType, isSelected: Bool) {
        self.type = type
        self.isSelected = isSelected
    }
    var body: some View {
        VStack {
            Text(type.text)
                .font(.pretendard(.semibold, size: 14))
                .foregroundStyle(isSelected ? .black : Color(hex: "7D848A"))
                .frame(width: 55, height: 30)
                .background{
                    isSelected ? Color.white : Color.black.opacity(0.05)
                }
                .cornerRadius(5)
        }
    }
}

struct RecentCallPickerView: View {
    @State var selectedTab : RecentCallType = .all
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack(spacing:10) {
                    ForEach(RecentCallType.allCases, id: \.self) { tab in
                        Button {
                            selectedTab = tab
                        } label: {
                            VStack {
                                RecentCallCell(type: tab, isSelected: selectedTab == tab)
                            }
                        }

                    }
                }
            
            }
        }
    }
}

#Preview {
    RecentCallPickerView()
}


struct Hello: View {
    var body: some View {
        Text("hello")
    }
}

struct Bye: View {
    var body: some View {
        Text("bye")
    }
}

struct fuckyou: View {
    var body: some View {
        Text("fuckyou")
    }
}
