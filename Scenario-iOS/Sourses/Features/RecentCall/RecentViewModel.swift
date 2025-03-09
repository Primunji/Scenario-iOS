//
//  Recent.swift
//  Scenario-iOS
//
//  Created by dgsw07 on 3/10/25.
//

import SwiftUI
import Alamofire

class RecentViewModel: ObservableObject {
    @Published var name = ""
    @Published var content = ""
    @Published var prompt = ""
    @Published var recent: [RecentModel] = []
    @Published var errorMessage: String?
    @Published var imageUrl: String = ""
    let serverUrl = ServerUrl.shared
    
    private var accessToken: String {
        return UserDefaults.standard.string(forKey: "accessToken") ?? ""
    }
    
    func fetchRecents() {
        let url = serverUrl.getUrl(for: "/recent")
        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(accessToken)"
        ]
        AF.request(
            "https://scenario-api.euns.dev/recent",
            method: .get,
            encoding: JSONEncoding.default,
            headers : header
        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: RecentResponse.self) { response in
            switch response.result {
            case.success(let result):
                print("연락처가져오기성공")
                print(self.accessToken)
                self.recent = result.data
            case.failure(let error):
                print(error)
            }
        }
    }
}



struct RecentModel: Decodable, Identifiable {
    let id: Int
    let scenario_id: Int
    let userId: Int
    let name: String
    let content: String
    let profile_url: String
    let created_at: String
}

struct RecentResponse : Decodable {
    let status: Int
    let state: String
    let message: String
    let data: [RecentModel]
}
