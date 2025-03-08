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
    var body: some View {
        VStack {
            Group {
                TextField("이름",text: $viewModel.username).textInputAutocapitalization(.never)
                TextField("비밀번호",text: $viewModel.password).textInputAutocapitalization(.never)
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
            
        }
        .navigationDestination(isPresented: $showMain) {
            MainTabView()
        }
    }
}

#Preview {
    SignUpView()
}
