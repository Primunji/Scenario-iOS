//
//  MessageHeader.swift
//  Scenario-iOS
//
//  Created by dgsw07 on 3/9/25.
//

import SwiftUI

struct MessageHeader: View {
    @Environment(\.dismiss) var dismiss
    var user: ContactModel
    var body: some View {
        GeometryReader { scale in
            VStack {
                Spacer()
                HStack(spacing: 10) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 24))
                            .foregroundStyle(.black)
                    }
                    VStack(alignment: .leading) {
                        Text(user.name)
                            .font(.pretendard(.semibold, size: 18))
                            .padding(.bottom,2)
                        Text(user.content)
                            .font(.pretendard(.medium, size: 16))
                    }
                    Spacer()
                }
            }
            .padding(.bottom,15)
            .frame(width: scale.size.width, height: scale.size.height)
        }
        .frame(height: 135)
        .background(Color.white)
    }
}
