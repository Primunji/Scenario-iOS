//
//  ContactMoreView.swift
//  Scenario
//
//  Created by dgsw07 on 3/6/25.
//

import SwiftUI

struct ContactMoreView: View {
    var body: some View {
        GeometryReader { scale in
            ZStack {
                Color.black.opacity(0.05)
                    .ignoresSafeArea()
                VStack(spacing: 0) {
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 180))
                        .foregroundColor(Color(hex: "C6C9CB"))
                    Text("이기찬")
                        .font(.pretendard(.semibold, size: 36))
                    Text("당신의 가족이 납치 되었습니다.")
                        .font(.pretendard(.medium, size: 16))
                    HStack {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 79, height: 37)
                            .foregroundColor(Color(hex: "F2F6FF"))
                            .background {
                                RoundedRectangle(cornerRadius: 5)
                            }
                            .cornerRadius(5)
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 79, height: 37)
                    }
                }
                .frame(width: scale.size.width,height: scale.size.width)
            }
        }
    }
}

#Preview {
    ContactMoreView()
}
