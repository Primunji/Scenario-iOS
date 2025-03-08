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
    @State private var isLoginSuccess = false
    @State private var showAlert = false
    @State private var next = false
    
    var body: some View {
        VStack(spacing:0) {
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
                
                LoginButton(action: {
                    next = true
                    viewModel.login { success in
                        if success {
                            isLoginSuccess = true
                        } else {
                            print(viewModel.loginerrorMessage ?? "로그인 실패")
                            showAlert = true
                        }
                    }
                }, text: "로그인")
               
                
            }
            .padding(.horizontal, 17)
            HStack {
                Text("아이디가 없나요?")
                NavigationLink {
                    SignUpView()
                        .navigationBarBackButtonHidden()
                } label: {
                    Text("회원가입")
                }
            }
            .padding(.top,19)
            .font(.pretendard(.regular, size: 16))
            .foregroundColor(Color(hex: "424242"))

        }
        .navigationDestination(isPresented: $next, destination: {
            MainTabView()
                .navigationBarBackButtonHidden()
        })
        .alert(isPresented: $showAlert) {
            Alert(title: Text("로그인 실패"),dismissButton: .cancel(Text("ㅇㅋ")))
        }
    }
}

#Preview {
    SignInView()
}

