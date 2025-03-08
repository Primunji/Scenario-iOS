//
//  SignUpView.swift
//  Senario
//
//  Created by dgsw07 on 3/5/25.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = SignUpViewModel()
    @State private var isLoginSuccess = false
    @State private var showAlert = false
    @State private var next = false
    
    var body: some View {
        VStack(spacing:0) {
            VStack(alignment:.leading, spacing: 10) {
                HStack {
                    AuthBackButton()
                        .padding(.bottom, 21)
                    Spacer()
                }
                
                Text("시나리오에 회원가입")
                    .font(.pretendard(.extrabold, size: 36))
                Text("아이디로 시나리오에 회원가입 하세요!")
                    .padding(.bottom, 31)
                
                HStack{
                    Text("아이디")
                        .font(.pretendard(.semibold, size: 16))
                        .foregroundStyle(Color(hex: "7D848A"))
                    Spacer()
                }
                TextField("아이디를 입력해 주세요.", text: $viewModel.username)
                    .textInputAutocapitalization(.never)
                    .textFieldStyle(CustomTextField(height: 55))
                    .font(.system(size: 16))
                    .padding(.bottom, 20)
                
                HStack{
                    Text("비밀번호")
                        .font(.pretendard(.semibold, size: 16))
                        .foregroundStyle(Color(hex: "7D848A"))
                    Spacer()
                }
                TextField("비밀번호를 입력해 주세요.", text: $viewModel.password)
                    .textInputAutocapitalization(.never)
                    .textFieldStyle(CustomTextField(height: 55))
                    .font(.system(size: 16))
                    .padding(.bottom, 20)
                
                HStack{
                    Text("비밀번호 확인")
                        .font(.pretendard(.semibold, size: 16))
                        .foregroundStyle(Color(hex: "7D848A"))
                    Spacer()
                }
                TextField("비밀번호를 한 번 더 입력해 주세요.", text: $viewModel.passwordCheck)
                    .textInputAutocapitalization(.never)
                    .textFieldStyle(CustomTextField(height: 55))
                    .font(.system(size: 16))
                    .padding(.bottom, 20)
                
                Spacer()
                
                SignUpButton(viewModel: viewModel, action: {
                    Task {
                        let signupResult = await viewModel.signUp()
                        if signupResult {
                            next = true
                        } else {
                            print("회원가입 실패")
                        }
                    }
                }, text: "회원가입")
                
                
            }
            .padding(.horizontal, 17)
            HStack {
                Text("아이디가 있나요?")
                NavigationLink {
                    SignUpView()
                        .navigationBarBackButtonHidden()
                } label: {
                    Text("로그인")
                }
            }
            .padding(.top,19)
            .font(.pretendard(.regular, size: 16))
            .foregroundColor(Color(hex: "424242"))
            
        }
        
        .navigationDestination(isPresented: $next, destination: {
            MainView()
                .navigationBarBackButtonHidden()
        })
        .alert(isPresented: $showAlert) {
            Alert(title: Text("로그인 실패"),dismissButton: .cancel(Text("ㅇㅋ")))
        }
    }
}

#Preview {
    SignUpView()
}
