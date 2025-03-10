//
//  CallViewModel.swift
//  Scenario-iOS
//
//  Created by dgsw18 on 3/10/25.
//

import Alamofire
import Foundation

class CallViewModel: ObservableObject {
    let serverUrl = ServerUrl.shared
    let scenario_id = "";
    let thread_id = "";
    private var accessToken: String {
        return UserDefaults.standard.string(forKey: "accessToken") ?? ""
    }
    
    
    
    
    func postCall(scenario_id:Int, completion: @escaping (Bool,String) -> Void) {
        let url = serverUrl.getUrl(for: "/call")
        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(accessToken)"
        ]
        
        let parameters: [String: Any] = [
            "scenario_id": scenario_id
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: CallResponse.self) { response in
                switch response.result {
                case .success(let callResponse):
                    print("전화걸기성공 (하트)")
                    let threadId = callResponse.data.thread_id
                    print(threadId)
                    completion(true, threadId)
                case .failure(let error):
                    print("요청 실패: \(error.localizedDescription)")
                    if let httpResponse = response.response {
                        print("응답 코드: \(httpResponse.statusCode)")
                    }
                    completion(false, "")
                }
            }
    }
}


