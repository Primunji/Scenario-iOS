//
//  LoginButton.swift
//  Scenario
//
//  Created by dgsw07 on 3/5/25.
//

import SwiftUI

struct LoginButton: View {
    @ObservedObject var viewModel: SignInViewModel
    let action: () -> Void
    let text: String

    var body: some View {
        GeometryReader { scale in
            Button {
                action()
            } label: {
                VStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: scale.size.width * 1, height: 65)
                        .foregroundColor(viewModel.isLoginDisabled ? Color(hex: "BEDBFF") : Color(hex: "2B7FFF"))
                        .overlay {
                            if viewModel.isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                                    .frame(width: 30, height: 30)
                                    .padding(5)
                            } else {
                                Text(text)
                                    .font(.pretendard(.semibold, size: 18))
                                    .foregroundStyle(.white)
                            }
                        }
                }
                .frame(width: scale.size.width, height: scale.size.height)
            }
            .disabled(viewModel.isLoginDisabled || viewModel.isLoading)
        }
        .frame(height: 65)
    }
}
