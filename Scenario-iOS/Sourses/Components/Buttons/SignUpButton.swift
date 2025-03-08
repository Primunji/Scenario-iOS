//
//  SignUpViewModel.swift
//  Scenario-iOS
//
//  Created by dgsw56 on 3/8/25.
//
import SwiftUI

struct SignUpButton: View {
    @ObservedObject var viewModel: SignUpViewModel
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
                        .foregroundColor(!viewModel.isSignUpDisabled ? Color(hex: "BEDBFF") : Color(hex: "2B7FFF"))
                        .overlay {
                            Text(text)
                                .font(.pretendard(.semibold, size: 18))
                                .foregroundStyle(.white)
                        }
                }
                .frame(width: scale.size.width, height: scale.size.height)

            }
            .disabled(!viewModel.isSignUpDisabled)
        }
        .frame(height: 65)
    }
    
}
