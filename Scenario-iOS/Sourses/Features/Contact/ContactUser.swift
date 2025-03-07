//
//  ContactUser.swift
//  Scenario
//
//  Created by dgsw07 on 3/6/25.
//
import SwiftUI

struct ContactUser: View {
    var name: String
    
    var body: some View {
        GeometryReader { scale in
            HStack(spacing: 10) {
                Image(systemName: "person.crop.circle.fill")
                    .foregroundColor(Color(hex: "C6C9CB"))
                    .font(.system(size: 60))
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.pretendard(.semibold, size: 18))
                    Text("당신의 가족이 납치 되었습니다")
                        .font(.pretendard(.medium, size: 16))
                }
                Spacer()
            }
            .frame(width: scale.size.width, height: scale.size.height)
            .padding(.leading, 27)
        }
        .frame(height: 65)
    }
}

struct ContactUserList: View {
    let users: [String]
    let limit: Int
    
    var body: some View {
        VStack {
            ForEach(users.prefix(limit), id: \.self) { user in
                ContactUser(name: user)
            }
        }
    }
}

#Preview {
    ContactUserList(users: ["이상은", "김강연", "이기찬", "박민주"], limit: 2)
}
