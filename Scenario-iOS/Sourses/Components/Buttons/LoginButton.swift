//
//  LoginButton.swift
//  Scenario
//
//  Created by dgsw07 on 3/5/25.
//

import SwiftUI

struct LoginButton: View {
    let action: () -> Void
    let text: String
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
                            Text(text)
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

#Preview {
    LoginButton(action: {
        print("d")
    }, text: "dd")
}

