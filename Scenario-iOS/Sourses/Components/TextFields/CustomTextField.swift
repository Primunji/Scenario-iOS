//
//  CustomTextField.swift
//  Senario
//
//  Created by dgsw07 on 3/5/25.
//



import SwiftUI

struct CustomTextField: TextFieldStyle {
    let height: CGFloat
    func _body(configuration: TextField<Self._Label>) -> some View {
        GeometryReader { scale in
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color(hex: "EDEEF1"))
                        .frame(width: scale.size.width * 1 ,height: height)
                    configuration
                        .font(.pretendard(.semibold, size: 16))
                        .foregroundColor(Color(hex: "7D848A"))
                        .padding()
                }
            }
            .frame(width: scale.size.width,height: scale.size.height)
        }
        .frame(height: 80)
    }
}
