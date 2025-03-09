//
//  CallModel.swift
//  Scenario-iOS
//
//  Created by dgsw18 on 3/10/25.
//

struct CallResponse: Decodable {
    let status: Int
    let state: String
    let message: String
    let data: CallData
}

struct CallData: Decodable {
    let thread_id: String
}
