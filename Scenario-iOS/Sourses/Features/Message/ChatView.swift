

import SwiftUI

struct ChatView: View {
    //    @StateObject var viewModel = MessageViewModel()
    @State var message = ""
    var body: some View {
        VStack(spacing:0) {
            MessageHeader()
                .padding(.horizontal,17)
            ZStack {
                Color.black.opacity(0.1)
                ScrollView {
                    LazyVStack(spacing:33) {
                        VStack {
                            MessageBox(isMySend: true)
                            MessageBox(isMySend: false)
                            MessageBox(isMySend: true)
                            MessageBox(isMySend: false)
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


#Preview {
    ChatView()
}
