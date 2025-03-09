//
//  Scenario_iOSApp.swift
//  Scenario-iOS
//
//  Created by dgsw07 on 3/8/25.
//

import SwiftUI

@main
struct Scenario_iOSApp: App {
    
    private var accessToken: String = "eyJhbGciOiJIUzM4NCJ9.eyJpZCI6MiwibmFtZSI6IuqwleyXsCIsInRva2VuX3R5cGUiOiJhY2Nlc3MiLCJpYXQiOjE3NDE1MTUxNzYsImV4cCI6MTc0MTUxODc3Nn0.xdRYwNw5RdFHTnYccctyxLyqrOytdVxmp52gJrupwjWnFh6ILRg9egd67NFaTQsi"
    @StateObject private var viewModel = SignInViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationStack {
//                MessageView()
//                if accessToken == nil {
//                    MainView()
//                } else {
//                    MainTabView()
//                }
                MainView()
//                TestPilotView()
            }
        }
    }
}
