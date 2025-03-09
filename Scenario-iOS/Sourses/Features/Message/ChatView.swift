

import SwiftUI


struct ChatView: View {
    @StateObject private var viewModel = ChatViewModel()
    private var timer: Timer?

    @StateObject var chatGateway = ChatGateway()
    @StateObject var callViewModel = CallViewModel()
    @State var thread_id = ""
    @State var message = ""
    var user: ContactModel
    
    // Make sure there's a public initializer that accepts the user parameter
    public init(user: ContactModel) {
        self.user = user
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
            MessageField(message: $message, thread_id: $thread_id)
        }
        .ignoresSafeArea()
        .onAppear {
            chatGateway.setViewModel(viewModel)

            DispatchQueue.global(qos: .background).async {
                callViewModel.postCall(scenario_id: user.scenario_id) { success, threadId in
                    if success {
                        thread_id = threadId
                        viewModel.fetchMessages(thread_id: thread_id)
                        print("✅ 메시지 로드 완료: \(viewModel.chats)")
                        chatGateway.connectWebSocket()
                        DispatchQueue.main.async {
                            
                            if viewModel.chats.isEmpty {
                                chatGateway.sendToServer(text: "새대화", thread_id: thread_id)
                                print("🚀 초기 메시지 요청 전송")
                            }
                        }

                    } else {
                        print("❌ 미션 실패 흐에에에")
                    }
                }
            }
        }
        .onDisappear{
            chatGateway.disconnectWebSocket()
        }
    }
    
}
