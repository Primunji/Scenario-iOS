//
//  MessageViewModel.swift
//  Scenario-iOS
//
//  Created by dgsw07 on 3/9/25.
//

import Foundation
import Alamofire

class ChatViewModel: ObservableObject {

    @Published var chats: [ChatModel] = []
    @Published var isLoading = false

    func addMessage(data:ChatModel) {
        chats.append(data)
    }
    
    func fetchMessages(thread_id:String ) {
        let url = "https://scenario-ai.euns.dev/chat?thread_id=\(thread_id)"
        let header: HTTPHeaders = [
            "Content-Type": "application/json",
        ]
        

        AF.request(
            url,
            method: .get,
            encoding: JSONEncoding.default,
            headers: header
        )
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ChatResponse.self) { response in
                self.isLoading = true
                switch response.result {
                case .success(let chatResponse):
                    self.isLoading = false
                    print("응답 상태: \(chatResponse.status)")
                    print("메시지 내용: \(chatResponse.message)")
                    for data in chatResponse.data {
                        print("메시지 ID: \(data.id), 내용: \(data.message)")
                 
                    }
                    
                    self.chats = chatResponse.data
                case .failure(let error):
                    print("데이터 요청 실패: \(error.localizedDescription)")
                    
                }
            }
    }

    // 메시지를 서버로 전송하는 함수
//    func sendMessage(_ message: String) {
//        let url = "https://scenario-api.euns.dev/room"  // 메시지를 전송할 URL
//        let parameters: [String: Any] = [
//            "content": message
//        ]
//
//        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
//            .validate()
//            .responseDecodable(of: MessageResponse.self) { response in
//                switch response.result {
//                case .success(let messageResponse):
//                    print("메시지 전송 성공: \(messageResponse.status)")
//                    self.fetchMessages()  // 메시지를 전송한 후 메시지 목록을 갱신
//                case .failure(let error):
//                    print("메시지 전송 실패: \(error)")
//                }
//            }
//    }
}



