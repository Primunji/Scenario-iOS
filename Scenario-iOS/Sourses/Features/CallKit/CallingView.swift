//
//  CallingView.swift
//  Scenario-iOS
//
//  Created by dgsw07 on 3/9/25.
//

import SwiftUI

struct CallingView: View {
    @State var thread_id = "thread_2TVeyaA8WAiawiMOt0Z0oBft";
    @StateObject private var speechRecognizer = SpeechRecognizer()
    @Binding var stopCalling : Bool
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(hex: "0066FF"), Color(hex: "80A9EB")], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            Image("CallLogo")
            
            VStack {
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 130))
                    .foregroundStyle(.white)
                
                Text("이기찬")
                    .font(.pretendard(.semibold, size: 36))
                    .foregroundStyle(.white)
                Spacer().frame(height: 400)
                HStack(spacing: 35) {
                    
                    
                    Circle().frame(width: 80,height: 80)
                        .foregroundStyle(.white.opacity(0.5))
                        .overlay {
                            Image(systemName: "speaker.wave.3.fill")
                                .foregroundStyle(.white)
                                .font(.system(size: 35))
                        }
                    
                    
                    DisconnectButton {
                        speechRecognizer.isListening = false
                        speechRecognizer.disconnectWebSocket()
                        speechRecognizer.stopListening()
                        withAnimation(.easeInOut(duration: 0.3)) {
                            stopCalling = false
                        }
                    }
                    
                    
                    
                    Circle().frame(width: 80,height: 80)
                        .foregroundStyle(.white.opacity(0.5))
                        .overlay {
                            Image(systemName: "mic.slash.fill")
                                .foregroundStyle(.white)
                                .font(.system(size: 35))
                        }
                    
                }
            }
        }
        .onDisappear {
            speechRecognizer.stopListening()
            speechRecognizer.disconnectWebSocket()
        }
        .onAppear {
            if (speechRecognizer.isListening) {
                speechRecognizer.stopListening()
            }else{
                CallManager().startCall(handle: "테스트")
                speechRecognizer.requestPermissions()
                speechRecognizer.connectWebSocket()
                speechRecognizer.sendToServer(text: "새대화", thread_id: thread_id)
                
                speechRecognizer.startListening()
                
            }
        }
    }
    }
    
    struct DisconnectButton: View {
        let action: () -> Void
        var body: some View {
            VStack {
                Button {
                    action()
                } label: {
                    Circle().frame(width: 80,height: 80)
                        .foregroundStyle(Color(hex: "2B7FFF"))
                        .overlay {
                            Image(systemName: "phone.down.fill")
                                .foregroundStyle(.white)
                                .font(.system(size: 35))
                        }
                }
            }
        }
    }
    
