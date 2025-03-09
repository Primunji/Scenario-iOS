

import SwiftUI


struct ChatView: View {
    @StateObject var viewModel = ChatViewModel()
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
                            ForEach(viewModel.chats, id: \.self) { newChat in
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
    }
    
}
