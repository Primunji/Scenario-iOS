//
//  ContactMoreView.swift
//  Scenario
//
//  Created by dgsw07 on 3/6/25.
//

import SwiftUI

struct ContactMoreView: View {
    var body: some View {
            ZStack {
                Color.black.opacity(0.05)
                    .ignoresSafeArea()
                VStack(spacing: 0) {
                    Spacer()
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 180))
                        .foregroundColor(Color(hex: "C6C9CB"))
                    Text("이기찬")
                        .font(.pretendard(.semibold, size: 36))
                    Text("당신의 가족이 납치 되었습니다.")
                        .font(.pretendard(.medium, size: 16))
                        .padding(.vertical,6).padding(.bottom,6)
                    
                    HStack {
                        ContactButton(text: "전화하기") //MARK: 버튼으로 만들어서 콜킷기능 넣으면됨
                        ContactButton(text: "문자하기")
                    }
                    .padding(.bottom,30)
                    
                    ContactCard(height: 353)
                        .frame(height: 353)
                        
                }
                .padding(.horizontal,20)

            }
        
    }
}

#Preview {
    ContactMoreView()
}
