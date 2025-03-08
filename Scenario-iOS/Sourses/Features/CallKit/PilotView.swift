//
//  PilotView.swift
//  Scenario-iOS
//
//  Created by dgsw07 on 3/9/25.
//

import SwiftUI
import Speech
import AVFoundation
import AVKit
import SwiftAudioEx

struct TestPilotView: View {
    @State var thread_id = "";
    @StateObject private var speechRecognizer = SpeechRecognizer()
    
    var body: some View {
        VStack {
            Text(speechRecognizer.transcribedText)
                .padding()
            
            TextField("스레드아이디", text:$thread_id)
            
            Button(action: {
                if (speechRecognizer.isListening) {
                    speechRecognizer.stopListening()
                }else{
                    CallManager().startCall(handle: "테스트")
                    speechRecognizer.requestPermissions()
                    speechRecognizer.connectWebSocket()
                    speechRecognizer.sendToServer(text: "새대화", thread_id: thread_id)
                    
                    speechRecognizer.startListening()

                }
            }) {
                Text(speechRecognizer.isListening ? "통화 종료" : "통화 시작")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .onDisappear {
            speechRecognizer.disconnectWebSocket()
        }
    }
}
//thread_2TVeyaA8WAiawiMOt0Z0oBft


class SpeechRecognizer: NSObject, ObservableObject, SFSpeechRecognizerDelegate {
    @Published var transcribedText = "여기에 인식된 텍스트 표시"
    @Published var isListening = false
    
    @Published var thread_id = ""
    
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ko-KR"))
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    private var silenceTimer: Timer?
    
    private var webSocketTask: URLSessionWebSocketTask?
    private let serverURL = URL(string: "wss://scenario-ai.euns.dev/call/ws")

    
    override init() {
        super.init()
        speechRecognizer?.delegate = self
    }

    // 음성 인식 권한 요청
    func requestPermissions() {
        SFSpeechRecognizer.requestAuthorization { status in
            DispatchQueue.main.async {
                if status != .authorized {
                    self.transcribedText = "음성 인식 권한이 필요합니다."
                }
            }
        }
    }

    // WebSocket 연결
    func connectWebSocket() {
        guard let url = serverURL else { return }
        let session = URLSession(configuration: .default)
        webSocketTask = session.webSocketTask(with: url)
        webSocketTask?.resume()
        
        receiveMessages() // 메시지 수신 시작
    }

    // WebSocket 연결 해제
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
                    self.handleReceivedMessage(text)
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

    private var audioPlayer: AVPlayer?

    private func handleReceivedMessage(_ text: String) {
        guard let data = text.data(using: .utf8),
              let json = try? JSONSerialization.jsonObject(with: data, options: []),
              let dict = json as? [String: Any],
              let status = dict["status"] as? String, status == "success",
              let audioURLString = dict["message"] as? String,
              let audioURL = URL(string: audioURLString) else {
            print("JSON 파싱 오류 또는 URL 없음")
            return
        }

        print("오디오 파일 URL: \(audioURL)")

        audioPlayer = AVPlayer(url: audioURL)
        

        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: audioPlayer?.currentItem, queue: .main) { _ in
            print("오디오 재생 완료, 마이크 다시 시작")
        }
        
        audioPlayer?.play()
    }

    private func reconnectWebSocket() {
        disconnectWebSocket()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.connectWebSocket()
        }
    }

    func startListening() {
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }

        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .measurement, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("오디오 세션 설정 오류: \(error.localizedDescription)")
            return
        }

        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else { return }

        recognitionRequest.shouldReportPartialResults = true

        let inputNode = audioEngine.inputNode
        inputNode.removeTap(onBus: 0)

        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            print("오디오 엔진 시작 오류: \(error.localizedDescription)")
            return
        }

        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { result, error in
            if let result = result {
                self.transcribedText = result.bestTranscription.formattedString

                self.resetSilenceTimer()

                if result.isFinal {
                    self.sendToServer(text: result.bestTranscription.formattedString, thread_id: self.thread_id)
                }
            }

        }

        isListening = true
    }

    func stopListening() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionRequest?.endAudio()
        recognitionRequest = nil
        recognitionTask = nil
        isListening = false

        silenceTimer?.invalidate()
    }

    private func resetSilenceTimer() {
        silenceTimer?.invalidate()
        silenceTimer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { _ in
            self.sendToServer(text: self.transcribedText, thread_id: self.thread_id)
            self.startListening()
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



#Preview {
    TestPilotView()
}
