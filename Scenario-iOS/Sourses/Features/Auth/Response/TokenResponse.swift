//
//  TokenResponse.swift
//  Scenario-iOS
//
//  Created by dgsw07 on 3/8/25.
//

import Foundation

struct TokenResponse: Codable {
    let data: TokenData
    let status: Int
    let message: String
}

struct TokenData: Codable {
    let accessToken: String
    let refreshToken: String
}
