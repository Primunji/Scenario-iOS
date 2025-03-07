//
//  BackButton.swift
//  Senario
//
//  Created by dgsw07 on 3/5/25.
//

import SwiftUI

struct BackButton: View {
    let text: String
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Button {
            dismiss()
        } label: {
            HStack(spacing: 2) {
                Image(systemName: "chevron.left").font(.system(size: 24).weight(.regular))
                Text(text)
                    .font(.pretendard(.bold, size: 20))
            }
        }

    }
}

#Preview {
    BackButton(text: "시나리오 제작")
}
