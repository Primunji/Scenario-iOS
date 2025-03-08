//
//  MessageCard.swift
//  Scenario-iOS
//
//  Created by dgsw07 on 3/9/25.
//

import SwiftUI

struct MessageCard: View {
    let height: CGFloat
    var body: some View {
        GeometryReader { scale in
            VStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: scale.size.width * 1,height: height)//499
                    .foregroundColor(.white)
                    .overlay {
                        VStack {
                            HStack {
                                Text("메시지")
                                    .font(.pretendard(.semibold, size: 16))
                                    .padding(20)
                                    .foregroundStyle(Color(hex: "2B7FFF"))
                                Spacer()
                            }
                            
                            Spacer()
                        }
                    }
            }
            .frame(width: scale.size.width,height: 526)//526
        }
    }
}


