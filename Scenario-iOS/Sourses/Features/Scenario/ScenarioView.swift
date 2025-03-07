//
//  ScenarioView.swift
//  Scenario
//
//  Created by dgsw07 on 3/6/25.
//

import SwiftUI


enum ScenarioTabType: CaseIterable {
    case contact
    case recentCall
    case message
    case scenario
    
    var title: String {
        switch self {
        case .contact:
            return "연락처"
        case .recentCall:
            return "최근 통화"
        case.message:
            return "메시지"
        case.scenario:
            return "시나리오"
        }
    }
    
    var icon: String {
        switch self {
        case .contact:
            return "person"
        case.recentCall:
            return "clock"
        case.message:
            return "message"
        case.scenario:
            return "person.fill.badge.plus"
        }
    }
}
