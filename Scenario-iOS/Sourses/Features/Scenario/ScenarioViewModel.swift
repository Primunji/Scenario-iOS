//
//  ScenarioViewModel.swift
//  Scenario-iOS
//
//  Created by dgsw07 on 3/8/25.
//

import Foundation
import Alamofire

class ScenarioViewModel: ObservableObject {
    @Published var scenario: [ScenarioModel] = []
    @Published var errorMessage: String?
    
    let serverUrl = ServerUrl.shared
    
    private var accessToken: String {
        return UserDefaults.standard.string(forKey: "accessToken") ?? ""
    }
    
    func fetchScenario() {
        let url = serverUrl.getUrl(for: "/scenario")
        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(accessToken)"
        ]
        
        
        AF.request("https://scenario-api.euns.dev/senario", method: .get, encoding: JSONEncoding.default, headers: header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ScenarioResponse.self) { response in
                switch response.result {
                case .success(let scenarioResponse):
                    print("✅ 시나리오 가져오기 성공")
                    DispatchQueue.main.async {
                        self.scenario = scenarioResponse.data
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.errorMessage = "오류 발생: \(error.localizedDescription)"
                        print(self.accessToken)
                    }
                    print("오류: \(error.localizedDescription)")
                    
                }
            }
    }
}
