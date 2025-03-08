//
//  MainViewButton.swift
//  Scenario-iOS
//
//  Created by dgsw07 on 3/8/25.
//

import SwiftUI


struct MainViewButton: View {
    let action: () -> Void
    var body: some View {
        GeometryReader { scale in
            
            Button {
                action()
            } label: {
                VStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: scale.size.width * 1,height: 65)
                        .foregroundColor(Color(hex: "2B7FFF"))
                        .overlay {
                            Text("아이디로 로그인")
                                .font(.pretendard(.semibold, size: 18))
                                .foregroundStyle(.white)
                        }
                }
                .frame(width: scale.size.width, height: scale.size.height)

            }
        }
        .frame(height: 65)
    }
    
}

