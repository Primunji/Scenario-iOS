//
//  CustomButtonView.swift
//  Senario
//
//  Created by dgsw07 on 3/5/25.
//

import SwiftUI

struct CustomButtonView: View {
    @State private var isSucess: Bool = true
    
    var body: some View {
        VStack(spacing: 30) {
            Toggle("성공여부", isOn: $isSucess)
                .frame(width: 120)
            AnimatedButton {
                Text("로그인")
            } action: {
                try? await Task.sleep(for: .seconds(2))
                return isSucess ? .success : .failed
            }
        }
    }
}

#Preview {
    CustomButtonView()
}



enum Status: Equatable {
    case idle
    case failed
    case success
}
struct AnimatedButton<ButtonContent: View>: View {
    var tint: Color = Color(hex: "2B7FFF")
    var content: () -> ButtonContent
    var action: () async -> Status
    
    
    @State private var isLoading: Bool = false
    @State private var isFailed: Bool = false
    @State private var status: Status = .idle
    
    
    var body: some View {
        GeometryReader { scale in
            VStack {
                Button {
                    Task {
                        isLoading = true
                        let status = await action()
                        
                        isFailed = status == .failed ?  true : false
                        
                        self.status = status
                        
                        try? await Task.sleep(for: .seconds(0.5))
                        self.status = .idle
                        
                        isLoading = false
                    }
                } label: {
                    content()
                        .foregroundColor(tint == .white ? nil : .white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 15)
                        .opacity(isLoading ? 0 : 1)
                        .lineLimit(1)
                        .frame(width: !isLoading ? scale.size.width * 0.9 : nil, height: 65)
                        .background(Color(status == .idle ? tint : status == .success ? Color(hex: "2B7FFF") : .red.opacity(0.8)).shadow(.drop(color: .gray.opacity(0.2), radius: 6)), in: Capsule())
                        .overlay {
                            if isLoading && status == .idle {
                                ProgressView()
                            }
                        }
                        .overlay{
                            if status != .idle {
                                Image(systemName: isFailed ? "exclamationmark.circle" : "checkmark")
                                    .fontWeight(.thin)
                                    .foregroundStyle(.white)
                            }
                        }
                }
                .disabled(isLoading)
                .animation(.easeInOut, value: isLoading)
                .animation(.easeInOut, value: status)
            }
            .frame(width: scale.size.width, height: scale.size.height)
        }
        .frame(height: 65)
    }
}
