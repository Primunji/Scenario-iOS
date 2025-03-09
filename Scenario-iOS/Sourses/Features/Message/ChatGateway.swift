//
//  ChatGateway.swift
//  Scenario-iOS
//
//  Created by dgsw18 on 3/10/25.
//

import SwiftUI
import Speech
import AVFoundation
import AVKit
import SwiftAudioEx

class ChatGateway: NSObject, ObservableObject {
    @Published var thread_id = ""
    
    var viewModel:ChatViewModel
    
    private var webSocketTask: URLSessionWebSocketTask?
    private let serverURL = URL(string: "wss://scenario-ai.euns.dev/chat/ws")

    
    override init() {
        self.viewModel = ChatViewModel()
        super.init()
    }
  
    func connectWebSocket() {
        guard let url = serverURL else { return }
        let session = URLSession(configuration: .default)
        webSocketTask = session.webSocketTask(with: url)
        webSocketTask?.resume()
        
        receiveMessages()
    }

    func disconnectWebSocket() {
        webSocketTask?.cancel(with: .goingAway, reason: nil)
        webSocketTask = nil
    }


    private func receiveMessages() {
        webSocketTask?.receive { result in
            switch result {
            case .success(let message):
                switch message {
                case .string(let text):
                    if (text == "end") {
                        self.disconnectWebSocket()
                        print("통화종료")
                    }else{
                        self.handleReceivedMessage(text)
                    }
                
                    print("서버 메시지 수신: \(text)")
                case .data(let data):
                    print("서버 데이터 수신: \(data)")
                @unknown default:
                    break
                }
                self.receiveMessages()
            case .failure(let error):
                print("WebSocket 오류: \(error.localizedDescription)")
                self.reconnectWebSocket()
            }
        }
    }

    private func handleReceivedMessage(_ text: String) {
        viewModel.fetchMessages(thread_id: thread_id)
    }

    private func reconnectWebSocket() {
        disconnectWebSocket()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.connectWebSocket()
        }
    }
    func sendToServer(text: String, thread_id: String) {
        guard !text.isEmpty else { return }
        self.thread_id = thread_id
        let json: [String: Any] = ["message": text, "thread_id": self.thread_id]
        if let jsonData = try? JSONSerialization.data(withJSONObject: json, options: []) {
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                let message = URLSessionWebSocketTask.Message.string(jsonString)
                
                webSocketTask?.send(message) { error in
                    if let error = error {
                        print("WebSocket 메시지 전송 오류: \(error.localizedDescription)")
                    } else {
                        print("WebSocket 메시지 전송 완료: \(jsonString)")
                    }
                }
            }
        }
    }
}
