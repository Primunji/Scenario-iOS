//
//  User.swift
//  Scenario
//
//  Created by dgsw07 on 3/6/25.
//

import Foundation

struct User: Codable, Identifiable {
    var id: Int
    var name: String
    var content: String
    var profile_url: String?
    var last_content: String?
    var is_success: Bool
}
