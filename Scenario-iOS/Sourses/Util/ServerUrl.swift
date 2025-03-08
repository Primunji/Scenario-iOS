//
//  ServerUrl.swift
//  Scenario-iOS
//
//  Created by dgsw07 on 3/8/25.
//

import Foundation

struct ServerUrl {
    var baseUrl = "https://scenario-api.euns.dev"
    
    func getUrl(for endpoint: String) -> String {
        return baseUrl + endpoint
    }
    static let shared = ServerUrl()
    
    private init() {}
}
