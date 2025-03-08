//
//  MessageBox.swift
//  Scenario-iOS
//
//  Created by dgsw07 on 3/8/25.
//

import SwiftUI

struct MessageBox: View {
    let color: Color
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 104,height: 39)
            .foregroundStyle(color)
            
    }
}

#Preview {
    MessageBox(color: Color(hex: "c4c4c4"))
}
