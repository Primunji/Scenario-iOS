//
//  ContactModel.swift
//  Scenario-iOS
//
//  Created by dgsw07 on 3/9/25.
//

import Foundation

struct ContactModel: Decodable, Identifiable {
    let id: Int
    let scenario_id: Int
    let userId: Int
    let name: String
    let content: String
    let profile_url: String
    let created_at: String
}

struct ContactResponse : Decodable {
    let status: Int
    let state: String
    let message: String
    let data: [ContactModel]
}





//
//{
//  "status": 1073741824,
//  "state": "string",
//  "message": "string",
//  "data": [
//    {
//      "id": 9007199254740991,
//      "scenario_id": 9007199254740991,
//      "userId": 9007199254740991,
//      "name": "string",
//      "content": "string",
//      "profile_url": "string",
//      "created_at": "2025-03-08T20:58:27.797Z"
//    }
//  ]
//}
