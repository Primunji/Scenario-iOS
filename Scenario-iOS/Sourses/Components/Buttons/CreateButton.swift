//
//  CreateButton.swift
//  Scenario-iOS
//
//  Created by dgsw07 on 3/9/25.
//

import SwiftUI

struct CreateButton: View {
    let action: () -> Void
    var body: some View {
        GeometryReader { scale in
            VStack {
                Button {
                    action()
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: scale.size.width * 1, height: 65)
                        .overlay {
                            Text("시나리오 업로드")
                                .font(.pretendard(.semibold, size: 18))
                                .foregroundStyle(.white)
                        }
                }
            }
            .frame(width: scale.size.width,height: scale.size.height)
        }
        .frame(height: 65)
    }
}
