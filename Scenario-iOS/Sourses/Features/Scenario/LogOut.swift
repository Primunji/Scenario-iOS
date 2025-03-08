//
//  ScenarioView.swift
//  Scenario
//
//  Created by dgsw07 on 3/6/25.
//

import SwiftUI

struct LogOutView: View {
    @StateObject var viewModel = ScenarioViewModel()
    @StateObject var loginViewModel = SignInViewModel()
    @State private var path = NavigationPath()
    @State var logOut = false
    @State var alertOn = false
    
    var body: some View {
        NavigationStack(path: $path) {
            GeometryReader { scale in
                VStack {
                    Button("로그아웃") {
                        loginViewModel.logout()
                        path = NavigationPath()
                        alertOn = true
                    }
                    
//                    ForEach(viewModel.scenario, id: \.id) { newScenario in
//                        VStack {
//                            Text(newScenario.name)
//                            AsyncImage(url: URL(string: newScenario.profileURL)) { image in
//                                image.resizable()
//                            } placeholder: {
//                                Circle()
//                            }
//                        }
//                    }
                }
                .frame(width: scale.size.width, height: scale.size.height)
                .onAppear {
                    viewModel.fetchScenario()
                }
                .navigationDestination(isPresented: $logOut) {
                    MainView()
                        .navigationBarBackButtonHidden()
                }
                .alert(isPresented: $alertOn) {
                    Alert(title: Text("로그아웃 하시겠습니까?"), message: Text("다시 로그인해야 합니다."), primaryButton: .cancel(), secondaryButton: .default(Text("예"), action: {
                        logOut = true
                    }))
                }
            }
        }
    }
}

#Preview {
    LogOutView()
}
