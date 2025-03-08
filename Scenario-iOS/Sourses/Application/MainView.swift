//
//  MainView.swift
//  Scenario
//
//  Created by dgsw07 on 3/5/25.
//

import SwiftUI

struct MainView: View {
    
    @State var next = false
    var body: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: 170)
            Image("Logo")
            Text("Scenario")
                .font(.pretendard(.semibold, size: 48))
                .foregroundStyle(
                    LinearGradient(colors: [.blue.opacity(0.6),Color(hex: "2B7FFF")], startPoint: .leading, endPoint: .trailing))
                .padding(9)
            
            
            Spacer()
            
            
            
            MainViewButton {
                next = true
            }
            
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
        .padding(.horizontal,16)
        .navigationDestination(isPresented: $next) {
            SignInView()
                .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    MainView()
}
