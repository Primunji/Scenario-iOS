//
//  ScenarioModel.swift
//  Scenario-iOS
//
//  Created by dgsw07 on 3/8/25.
//

import Foundation

struct ScenarioModel: Decodable, Identifiable {
    let id: Int
    let name: String
    let content: String
    let profile_url: String
    let actor_id: String
    let prompt: String
    let assistant_id: String
    let created_at: String
}

struct ScenarioResponse: Decodable {
    let status: Int
    let state: String
    let message: String
    let data: [ScenarioModel]
}
