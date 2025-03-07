//
//  TabViewCell.swift
//  Scenario-iOS
//
//  Created by dgsw07 on 3/8/25.
//


//
//  TabViewCell.swift
//  Scenario
//
//  Created by dgsw07 on 3/5/25.
//

import Foundation
import SwiftUI

struct TabViewCell: View {
    let type: TabbedItems
    let isSelected: Bool
    
    init(type: TabbedItems, isSelected: Bool) {
        self.type = type
        self.isSelected = isSelected
    }
    var body: some View {
        VStack {
            Group {
                Image(systemName: type.icon)
                    .font(.system(size: 18))
                    .padding(.bottom,3)
                Text(type.title)
                    .font(.pretendard(.medium, size: 12))
            }
            .foregroundColor(isSelected ? Color(hex: "2B7FFF") : .black.opacity(0.6))
        }
    }
}
