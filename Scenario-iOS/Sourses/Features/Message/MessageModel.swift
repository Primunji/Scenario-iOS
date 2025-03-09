//
//  MessageModel.swift
//  Scenario-iOS
//
//  Created by dgsw07 on 3/9/25.
//
import Foundation



struct MessageModel: Decodable, Identifiable {
    let id: Int64
    let thread_id: String
    let scenario_id: Int64
    let userId: Int64
    let name: String
    let content: String
    let profile_url: String
    let recent_message: String
    let last_message: String
    let created_at: String
}

struct MessageResponse : Decodable {
    let status: Int
    let state: String
    let message: String
    let data: [MessageModel]
}


