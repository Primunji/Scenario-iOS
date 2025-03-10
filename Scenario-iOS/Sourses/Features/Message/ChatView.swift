

import SwiftUI
import Foundation

struct ChatView: View {
    @StateObject private var viewModel = ChatViewModel()
    private var timer: Timer?

    @StateObject var chatGateway = ChatGateway()
    @StateObject var callViewModel = CallViewModel()
    @State var select_thread_id = ""
    @State var message = ""
    var user: ContactModel
    var is_first = false
    
    // Make sure there's a public initializer that accepts the user parameter
    public init(user: ContactModel, is_first: Bool, thread_id: String) {
        self.user = user
        self.is_first = is_first
        self._select_thread_id = State(initialValue: thread_id)
    }
    
    var body: some View {
        VStack(spacing:0) {
            MessageHeader(user: user)
                .padding(.horizontal,17)
            ZStack {
                Color.black.opacity(0.1)
                ScrollView {
                    LazyVStack(spacing: 33) {
                        ForEach(viewModel.chats, id: \.id) { newChat in
                            if newChat.message != "새대화" {
                                MessageBox(message: newChat)
                            }
                        }
                        .padding(.horizontal, 17)
                        .padding(.vertical, 35)
                    }
                }
            }
            MessageField(message: $message, thread_id: $select_thread_id, action: {
                DispatchQueue.global(qos: .background).async {
                    DispatchQueue.main.async {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "HH:mm"
                        let currentTime = dateFormatter.string(from: Date())
                        viewModel.chats.append(ChatModel(id: "1", thread_id: "", name: "유저", content: "", message: message, is_bot: false, created_at: currentTime))
                        chatGateway.sendToServer(text: message, thread_id: select_thread_id)
                        message = ""
                    }
                }
            })
        }
        .ignoresSafeArea()
        .onAppear {
            if is_first{
                chatGateway.setViewModel(viewModel)
                DispatchQueue.global(qos: .background).async {
                    callViewModel.postCall(scenario_id: user.scenario_id) { success, threadId in
                        if success {
                            select_thread_id = threadId
                            viewModel.fetchMessages(thread_id: select_thread_id)
                            print("✅ 메시지 로드 완료: \(viewModel.chats)")
                            chatGateway.connectWebSocket()
                            DispatchQueue.main.async {
                                
                                if viewModel.chats.isEmpty {
                                    chatGateway.sendToServer(text: "새대화", thread_id: select_thread_id)
                                    print("🚀 초기 메시지 요청 전송")
                                }
                            }
                            
                        } else {
                            print("❌ 미션 실패 흐에에에")
                        }
                    }
                }
            }else{
                chatGateway.setViewModel(viewModel)
                   DispatchQueue.global(qos: .background).async {
                       // select_thread_id를 재할당하지 않음 (이미 초기화 함수에서 설정됨)
                       viewModel.fetchMessages(thread_id: select_thread_id)
                       print("✅ 메시지 로드 완료: \(viewModel.chats)")
                       print("사용 중인 thread_id: \(select_thread_id)")
                       chatGateway.connectWebSocket()
                   }
            }
        }
        .onDisappear{
            chatGateway.disconnectWebSocket()
        }
    }
    
}

