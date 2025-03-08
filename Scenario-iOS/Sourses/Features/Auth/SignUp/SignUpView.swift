//
//  SignUpView.swift
//  Senario
//
//  Created by dgsw07 on 3/5/25.
//

import SwiftUI

struct SignUpView: View {
    @State var showMain = false
    @StateObject var viewModel = SignUpViewModel()
    @State var passwordCheck = ""
    var body: some View {
        VStack {
            Group {
                TextField("이름",text: $viewModel.username).textInputAutocapitalization(.never)
                TextField("비밀번호",text: $viewModel.password).textInputAutocapitalization(.never)
                TextField("비밀번호 확인",text: $passwordCheck).textInputAutocapitalization(.never)
            }
            .padding()
            
            Button {
                Task {
                    let signupResult = await viewModel.signUp()
                    if signupResult {
                        showMain = true
                    } else {
                        print("회원가입 실패")
                    }
                }
            } label: {
                Text("Button")
            }
            .disabled(!isPasswordSame(password: viewModel.password, passwordCheck: passwordCheck))
            
        }
        .navigationDestination(isPresented: $showMain) {
            MainTabView()
        }
    }
    func isPasswordSame(password: String, passwordCheck: String) -> Bool {
        return password == passwordCheck
    }
}

#Preview {
    SignUpView()
}
