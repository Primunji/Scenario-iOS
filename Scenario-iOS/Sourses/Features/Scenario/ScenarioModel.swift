//
//  ScenarioModel.swift
//  Scenario-iOS
//
//  Created by dgsw07 on 3/8/25.
//

import Foundation

struct ScenarioModel: Decodable, Identifiable {
    var id: Int
    var name: String
    var content: String
    var profile_url: String
    var actor_id: String
    var prompt: String
    var assistant_id: String
    var created_at: String
}

struct ScenarioResponse: Decodable {
    var status: Int
    var state: String
    var message: String
    var data: [ScenarioModel]
}
