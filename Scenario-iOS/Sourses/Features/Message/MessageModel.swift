//
//  MessageModel.swift
//  Scenario-iOS
//
//  Created by dgsw07 on 3/9/25.
//

import Foundation

struct MessageResponse: Decodable {
    let status: Int
    let state: String
    let message: String
    let data: [MessageModel]
}

struct MessageModel: Codable {
    let id: Int
    let thread_id: String
    let scenario_id: Int
    let userId: Int
    let name: String
    let content: String
    let profile_url: String
    let recent_message: String
    let last_message: String
    let created_at: Date
}

