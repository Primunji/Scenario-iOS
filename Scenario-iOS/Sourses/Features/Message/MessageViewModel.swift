//
//  MessageViewModel.swift
//  Scenario-iOS
//
//  Created by dgsw07 on 3/9/25.
//

import Foundation
import Alamofire

class MessageViewModel: ObservableObject {
    @Published var messages: [MessageModel] = []
    private var accessToken: String {
        return UserDefaults.standard.string(forKey: "accessToken") ?? ""
    }
    
    func fetchMessageRooms() {
        let url = "https://scenario-api.euns.dev/room"
        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(accessToken)"
        ]
        
        AF.request(
            url,
            method: .get,
            encoding: JSONEncoding.default,
            headers: header
        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: MessageResponse.self) { response in
            switch response.result {
            case .success(let messageResponse):
                print("메시지성공")
                print("응답 상태: \(messageResponse.status)")
                print("메시지 내용: \(messageResponse.message)")
                print("\(messageResponse.data)")
                
                self.messages = messageResponse.data
            case .failure(let error):
                print("데이터 요청 실패: \(error.localizedDescription)")
                
            }
        }
    }
}



