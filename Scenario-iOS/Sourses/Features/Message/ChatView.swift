//
//  ChatView.swift
//  Scenario-iOS
//
//  Created by dgsw07 on 3/8/25.
//

import SwiftUI

struct ChatView: View {
    var body: some View {
        GeometryReader { scale in
            VStack(spacing:0) {
                HStack {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 24))
                    VStack(alignment: .leading, spacing: 5) {
                        Text("김강연")
                            .font(.pretendard(.semibold, size: 18))
                        Text("당신의 가족이 납치되었습니다")
                            .font(.pretendard(.medium, size: 16))
                    }
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    ChatView()
}
