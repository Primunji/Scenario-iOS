//
//  ScenarioModel.swift
//  Scenario-iOS
//
//  Created by dgsw07 on 3/8/25.
//

import Foundation

struct ScenarioModel: Codable, Identifiable, Hashable {
    var id: Int
    var name: String
    var content: String
    var profileURL: String
    var actorID: String
    var prompt: String
    var assistantID: String
    var createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, content, prompt
        case profileURL = "profile_url"
        case actorID = "actor_id"
        case assistantID = "assistant_id"
        case createdAt = "created_at"
    }
}

struct ScenarioResponse: Decodable {
    var status: Int
    var state: String
    var message: String
    var data: [ScenarioModel]
}
