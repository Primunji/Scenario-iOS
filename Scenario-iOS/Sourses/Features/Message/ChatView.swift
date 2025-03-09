

import SwiftUI


struct ChatView: View {
    @StateObject var viewModel = ChatViewModel()
    @StateObject var chatGateway = ChatGateway()
    @StateObject var callViewModel = CallViewModel()
    @State var thread_id = ""
    @State var message = ""
    var user: ContactModel
    var body: some View {
        VStack(spacing:0) {
            MessageHeader(user: user)
                .padding(.horizontal,17)
            ZStack {
                Color.black.opacity(0.1)
                ScrollView {
                    LazyVStack(spacing:33) {
                        VStack {
                            ForEach(viewModel.chats, id: \.id) { newChat in
                                MessageBox(message: newChat, isMySend: newChat.is_bot)
                            }
                        }
                        .padding(.horizontal,17)
                        .padding(.vertical,35)
                    }
                }
            }
            MessageField(message: $message)
        }
        .ignoresSafeArea()
        .onAppear {

            callViewModel.postCall(scenario_id: user.scenario_id) { success, threadId in
                if success {
                    thread_id = threadId
                    viewModel.fetchMessages(thread_id: thread_id)
                    print("\(thread_id) 스레드 갖고왓어요")
                    chatGateway.connectWebSocket()
                    if viewModel.chats.isEmpty {
                        chatGateway.sendToServer(text: "새대화", thread_id: thread_id)
                    }
                    
                } else {
                    print("미션 실패 흐에에에")
                }
            }
           
        }
        .onDisappear{
            chatGateway.disconnectWebSocket()
        }
    }
    
}
