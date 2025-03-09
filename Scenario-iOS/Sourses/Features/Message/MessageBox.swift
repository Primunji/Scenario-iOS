//
//  MessageBox.swift
//  Scenario-iOS
//
//  Created by dgsw07 on 3/8/25.
//

import SwiftUI
import Foundation


func convertISO8601StringToDate(_ dateString: String) -> String? {
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds] // 소수점 이하 초 단위 지원
    if let date = formatter.date(from: dateString) {
        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "HH:mm"
        return displayFormatter.string(from: date)
    } else {
        return nil
    }
}

struct MessageBox: View {
    var message : ChatModel
    @State var time = convertISO8601StringToDate("2025-03-09T21:19:32.107000")
    var body: some View {
        HStack(spacing: 0) {
            if message.is_bot {
                HStack {
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 56))
                        .foregroundStyle(Color(hex:"#C6C9CB"))
                    VStack(spacing: 4) {
                        Text(message.name)
                            .font(.pretendard(.semibold, size: 14))
                            .frame(maxWidth: 290, alignment: .leading)
                        HStack(alignment: .bottom,spacing: 9) {
                            Text(message.message)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 15)
                                .font(.pretendard(.semibold, size: 16))
                                .foregroundStyle(.white)
                                .background {
                                    Color(hex: "2B7FFF")
                                }
                                .cornerRadius(10)
                                .fixedSize(horizontal: false, vertical: true)
                            Text("\(time)")
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
                    Text("\(time)")
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
