//
//  ContactButton.swift
//  Scenario-iOS
//
//  Created by dgsw07 on 3/8/25.
//

import SwiftUI

struct ContactButton: View {
    let text: String
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .frame(width: 79, height: 37)
            .foregroundColor(Color(hex: "F2F6FF"))
            .cornerRadius(5)
            .overlay {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(lineWidth: 0.2)
                        .foregroundStyle(Color(hex: "51A2FF"))
                    Text(text)
                        .font(.pretendard(.semibold, size: 14))
                        .foregroundColor(Color(hex: "51A2FF"))
                }
            }
    }
    
}
#Preview {
    ContactButton(text: "전화하기")
}
