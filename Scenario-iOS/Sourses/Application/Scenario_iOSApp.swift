//
//  Scenario_iOSApp.swift
//  Scenario-iOS
//
//  Created by dgsw07 on 3/8/25.
//

import SwiftUI

@main
struct Scenario_iOSApp: App {
    @AppStorage("accessToken")
    private var accessToken: String?
    @StateObject private var viewModel = SignInViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if accessToken == nil {
                    MainView()
                } else {
                    MainTabView()
                }
//                MainView()
//                TestPilotView()
            }
        }
    }
}
