//
//  VoiceItem.swift
//  Scenario-iOS
//
//  Created by dgsw07 on 3/8/25.
//

import SwiftUI
import AVFoundation

struct VoiceItem: View {
    @State private var audioPlayer: AVAudioPlayer?
    
    var body: some View {
        GeometryReader { scale in
            HStack(spacing: 0) {
                Image("sangeun")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 130)
                
                VStack(spacing: 0) {
                    Text("상은")
                        .font(.pretendard(.bold, size: 20))
                    
                    Button(action: {
                        playAudio()
                    }) {
                        Image(systemName: "play.circle.fill")
                            .font(.system(size: 40))
                    }
                }
                
                Capsule()
                    .frame(width: scale.size.width * 0.45, height: 8.098)
                    .padding(.top, 20)
                    .padding(.leading, 20)
                    .foregroundStyle(Color(hex: "D9D9D9"))
            }
            .frame(width: scale.size.width, height: scale.size.height)
        }
    }
    
    func playAudio() {
        if let url = Bundle.main.url(forResource: "sangeun_audio", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                print("음악 파일을 재생할 수 없습니다: \(error.localizedDescription)")
            }
        } else {
            print("오디오 파일을 찾을 수 없습니다.")
        }
    }
}

#Preview {
    VoiceItem()
}
