//
//  MessageModel.swift
//  Scenario-iOS
//
//  Created by dgsw07 on 3/9/25.
//

import Foundation

struct ChatResponse: Decodable {
    let status: Int
    let state: String
    let message: String
    let data: [ChatModel]
}

struct ChatModel: Codable, Identifiable, Hashable {
    let id: String
    let thread_id: String
    let name: String
    let content: String
    let message: String
    let is_bot: Bool
    let created_at: Date
}


