//
//  MessageBox.swift
//  Scenario-iOS
//
//  Created by dgsw07 on 3/8/25.
//

import SwiftUI
import Foundation


struct MessageBox: View {
    @StateObject var viewModel = ChatViewModel()
    var message : ChatModel
    var body: some View {
        HStack(spacing: 0) {
            if message.is_bot {
                HStack(alignment: .top) {
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 56))
                        .foregroundStyle(Color(hex:"#C6C9CB"))
                    VStack(spacing: 4) {
                        Text(message.name)
                            .font(.pretendard(.semibold, size: 14))
                            .frame(maxWidth: 290, alignment: .leading)
                        HStack(alignment: .bottom,spacing: 9) {
                            Text(viewModel.isLoading ? "생성중.." : message.message)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 15)
                                .font(.pretendard(.semibold, size: 16))
                                .foregroundStyle(.white)
                                .background {
                                    Color(hex: "2B7FFF")
                                }
                                .cornerRadius(10)
                                .fixedSize(horizontal: false, vertical: true)
                            Text("\(message.created_at)")
                                .font(.pretendard(.medium, size: 14))
                                .foregroundStyle(.black.opacity(0.4))
                        }
                        .frame(maxWidth: 290, alignment: .leading)

                    }
                }
                Spacer()
            } else {
                Spacer()
                HStack(alignment: .bottom,spacing: 9) {
                    Text("\(message.created_at)")
                        .font(.pretendard(.medium, size: 14))
                        .foregroundStyle(.black.opacity(0.4))
                    Text(message.message)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 15)
                        .font(.pretendard(.semibold, size: 16))
                        .foregroundStyle(.white)
                        .background {
                            Color(hex: "343434")
                        }
                        .cornerRadius(10)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(maxWidth: 290, alignment: .trailing)

            }
        }
    }
}
