//
//  ContactView.swift
//  Scenario
//
//  Created by dgsw07 on 3/6/25.
//

import SwiftUI

struct ContactView: View {
    @State var next = false
    @State var searchText = ""
    @State var seeMore = false
    @State private var selectedUser: ContactModel?
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.05)
                .ignoresSafeArea()
            VStack(spacing: 0) {
                HStack {
                    Image("Logo")
                        .resizable()
                        .frame(width: 30, height: 30)
                        
                    Text("연락처")
                        .font(.pretendard(.semibold, size: 36))
                        .padding(.bottom, 10)
                        .padding(.top, 11)
                    Spacer()
                }
                
                CustomSearchField(placeholder: "검색하기", searchText: $searchText)
                
                ContactCard(viewModel: ContactViewModel(), onSelect: { _ in }, height: 499)

                
                AddButton(text: "연락처 추가") {
                    // 연락처 추가 로직
                }
                .padding(.bottom, 17)
            }
            .padding(.horizontal, 16)
            
        }
        .navigationDestination(isPresented: $next) {
            if let user = selectedUser {
                ContactMoreView(user: user, callViewModel: CallViewModel())
                    .navigationBarBackButtonHidden()
            }
        }
    }
}



#Preview {
//    ContactView()
    MainTabView()
}


