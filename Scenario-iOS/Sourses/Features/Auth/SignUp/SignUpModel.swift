//
//  SignUpModel.swift
//  Scenario-iOS
//
//  Created by dgsw07 on 3/8/25.
//

import Foundation

struct SignUpModel: Codable {
    var username: String
    var password: String
}

struct SignUpResponse: Decodable {
    var username: String
    var password: String
}
