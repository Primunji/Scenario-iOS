//
//  addButton.swift
//  Scenario
//
//  Created by dgsw07 on 3/6/25.
//

import SwiftUI

struct AddButton: View {
    let text: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 135,height: 39)
                .foregroundColor(Color(hex:"#F2F6FF"))
                .overlay {
                    HStack {
                        Image(systemName: "plus")
                            .font(.pretendard(.regular, size: 16))
                        Text(text)
                            .font(.pretendard(.semibold, size: 14))
                    }
                    .foregroundColor(Color(hex: "#1068ED"))
                    .padding(10)
                }
        }
    }
}

#Preview {
    AddButton(text: "연락처 추가") {
        print("원하는화면으로이동")
    }
}
