//
//  ContactMoreView.swift
//  Scenario
//
//  Created by dgsw07 on 3/6/25.
//

import SwiftUI

struct ContactMoreView: View {
    var user: ContactModel
    @StateObject var viewModel = ChatViewModel()
    @StateObject private var speechRecognizer = SpeechRecognizer()
    @ObservedObject var callViewModel: CallViewModel;
    @State var callingViewOn = false
    @State var next = false
    @State var thread_id = ""
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            if callingViewOn {
                CallingView(stopCalling: $callingViewOn, user: user, thread_id: thread_id)
            } else {
                ZStack {
                    Color.black.opacity(0.05)
                        .ignoresSafeArea()
                    VStack(spacing: 0) {
                        HStack {
                            Button {
                                dismiss()
                            } label: {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 24))
                                    .foregroundStyle(.black)
                            }
                            Spacer()
                        }
                        Spacer()
                        Image(systemName: "person.crop.circle.fill")
                            .font(.system(size: 180))
                            .foregroundColor(Color(hex: "C6C9CB"))
                        Text(user.name)
                            .font(.pretendard(.semibold, size: 36))
                        Text(user.content)
                            .font(.pretendard(.medium, size: 16))
                            .padding(.vertical,6).padding(.bottom,6)
                        
                        HStack {
                            ContactButton(action: {
                                callViewModel.postCall(scenario_id: user.scenario_id) { success, threadId in
                                    if success {
                                        withAnimation(.easeInOut(duration: 0.3)) {
                                            thread_id = threadId
                                            callingViewOn = true
                                            print("\(thread_id) 스레드 갖고왓어요")
                                        }
                                    
                                    } else {
                                        print("미션 실패 흐에에에")
                                    }
                                }
                           
                            }, text: "전화하기") //MARK: 버튼으로 만들어서 콜킷기능 넣으면됨
                            // Text(speechRecognizer.isListening ? "통화 종료" : "통화 시작")
                            ContactButton(action: {
                                next = true
                            }, text: "문자하기")
                        }
                        .padding(.bottom,30)
                        
                        ContactCard(viewModel: ContactViewModel(), onSelect: { _ in }, height: 553)
                            .frame(height: 403)
                        
                    }
                    .padding(.horizontal,20)
                    
                }
            }
        }
        .navigationDestination(isPresented: $next) {
            ChatView(user: user)
                .navigationBarBackButtonHidden()
            
        }
    }
}
