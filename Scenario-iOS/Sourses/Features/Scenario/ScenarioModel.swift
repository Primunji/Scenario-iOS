//
//  ScenarioModel.swift
//  Scenario-iOS
//
//  Created by dgsw07 on 3/8/25.
//

import Foundation

struct ScenarioModel: Codable {
    var name: String
    var content: String
    var prompt: String
}


struct ScenarioResponse : Decodable {
    var success: Bool
    var reason : String
}
