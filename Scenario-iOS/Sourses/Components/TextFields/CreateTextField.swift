//
//  CreateTextField.swift
//  Senario
//
//  Created by dgsw07 on 3/5/25.
//

import SwiftUI

struct CreateTextField: TextFieldStyle {
    let title: String
    func _body(configuration: TextField<Self._Label>) -> some View {
        GeometryReader { scale in
            VStack(alignment:.leading) {
                Text(title)
                    .font(.pretendard(.semibold, size: 16))
                    .foregroundStyle(Color(hex: "7D848A"))
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color(hex: "EDEEF1"))
                    configuration
                        .font(.pretendard(.semibold, size: 16))
                        .foregroundColor(Color(hex: "7D848A"))
                        .padding()
                }
            }
            .frame(width: scale.size.width, height: scale.size.height)
        }
        .frame(height: 55)
    }
}



