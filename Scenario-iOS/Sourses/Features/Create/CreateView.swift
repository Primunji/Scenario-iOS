//
//  CreateView.swift
//  Senario
//
//  Created by dgsw07 on 3/5/25.
//
import SwiftUI

struct CreateView: View {
    @State private var isSuccess: Bool = false
    @State private var scenarioText: String = ""
    @FocusState private var isTextFieldFocused: Bool
    private let placeholder: String = "예) 친구를 만나서 영화도 보고 맛있는 것도 먹었어"
    
    var body: some View {
        GeometryReader { scale in
            VStack(spacing: 5) {
                HStack {
                    BackButton(text: "시나리오 제작")
                    Spacer()
                }
                .padding(.bottom, 33)
                
                ScrollView {
                    ProfileImage()
                    
                    TextField("시나리오 제목을 입력하세요", text: $scenarioText)
                        .textFieldStyle(CreateTextField(title: "인물이름"))
                        .focused($isTextFieldFocused)
                        .padding(.bottom, 40)
                    
                    TextField("시나리오 제목을 입력하세요", text: $scenarioText)
                        .textFieldStyle(CreateTextField(title: "인물이름"))
                        .focused($isTextFieldFocused)
                        .padding(.bottom, 30)
                    
                    VStack(alignment: .leading) {
                        Text("시나리오 내용")
                            .font(.pretendard(.semibold, size: 16))
                            .foregroundStyle(Color(hex: "7D848A"))
                        
                        TextEditor(text: $scenarioText)
                            .customStyleEditor(placeholder: placeholder, userInput: $scenarioText)
                    }
                }
                
                AnimatedButton {
                    Text("시나리오 제작")
                        .font(.pretendard(.semibold, size: 18))
                } action: {
                    do {
                        try await Task.sleep(for: .seconds(2))
                        return isSuccess ? .success : .failed
                    } catch {
                        return .failed
                    }
                }
                .padding(.top, 10) 
            }
            .padding(.horizontal, 17)
        }
    }
}

#Preview {
    CreateView()
}
