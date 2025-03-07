//
//  SignInView.swift
//  Senario
//
//  Created by dgsw07 on 3/5/25.
//

import SwiftUI

struct SignInView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = SignInViewModel()
    @State private var next = false
    
    var body: some View {
        VStack(alignment:.leading, spacing: 0) {
            HStack {
                AuthBackButton()
                    .padding(.bottom, 21)
                Spacer()
            }
            Text("시나리오에 로그인")
                .font(.pretendard(.extrabold, size: 36))
                .padding(.bottom, 5)
            Text("아이디로 시나리오에 로그인 하세요!")
            
            TextField("아이디를 입력하세요", text: $viewModel.username)
                .padding(.top, 25)
                .textFieldStyle(CustomTextField(height: 65))
                
            
            TextField("비밀번호를 입력하세요", text: $viewModel.password)
                .padding(.top, 25)
                .textFieldStyle(CustomTextField(height: 65))
                
            Spacer()
            
            LoginButton(destination: MainTabView().navigationBarBackButtonHidden(), text: "로그인")
            
        }
        .padding(.horizontal, 17)
    }
}

#Preview {
    SignInView()
}

