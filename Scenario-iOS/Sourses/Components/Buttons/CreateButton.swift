//
//  CreateButton.swift
//  Scenario-iOS
//
//  Created by dgsw07 on 3/9/25.
//

import SwiftUI

struct CreateButton: View {
    let action: () -> Void
    @Binding var isLoading: Bool
    @Binding var isSuccess: Bool?
    
    
    var body: some View {
        GeometryReader { scale in
            VStack {
                Button {
                    isLoading = true
                    action()
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: scale.size.width * 1, height: 65)
                        .overlay {
                            if isLoading {
                                VStack {
                                    Text("시나리오 제작중...")
                                        .font(.pretendard(.semibold, size: 18))
                                        .foregroundStyle(.white)
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                        .scaleEffect(1.5)
                                }
                            } else if let isSuccess = isSuccess {
                                Text(isSuccess ? "업로드 성공!" : "업로드 실패")
                                    .font(.pretendard(.semibold, size: 18))
                                    .foregroundStyle(.white)
                                    .padding()
                                    .animation(.easeInOut(duration: 0.5), value: isSuccess)
                            } else {
                                Text("시나리오 업로드")
                                    .font(.pretendard(.semibold, size: 18))
                                    .foregroundStyle(.white)
                            }
                        }
                }
                .disabled(isLoading)
            }
            .frame(width: scale.size.width, height: scale.size.height)
        }
        .frame(height: 65)
    }
}
