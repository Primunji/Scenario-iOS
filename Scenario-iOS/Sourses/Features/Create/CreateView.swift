//
//  CreateView.swift
//  Senario
//
//  Created by dgsw07 on 3/5/25.
//
import SwiftUI

struct CreateView: View {
    @Environment(\.dismiss) var dismiss
    @State var isLoading = false
    @State var isSuccess: Bool? = nil
    @State var scenarioText: String = ""
    @State var alertOn = false
    @FocusState private var isTextFieldFocused: Bool
    private let placeholder: String = "부적절한 시나리오는 승인이 되지 않을수도 있습니다. 모든 시나리오는 관리자의 승인후 추가 됩니다."
    @StateObject var viewModel = ScenarioViewModel()
    
    
    var body: some View {
        GeometryReader { scale in
            VStack(spacing: 5) {
                HStack {
                    BackButton(text: "시나리오 제작")
                    Spacer()
                }
                .padding(.bottom, 33)
                
                ScrollView {
                    ProfileImage(viewModel: viewModel)
                    
                    TextField("인물이름을 입력해주세요.", text: $viewModel.name)
                        .textFieldStyle(CreateTextField(title: "인물이름"))
                        .focused($isTextFieldFocused)
                        .padding(.bottom, 40)
                    
                    TextField("인물을 설명 해주세요.", text: $viewModel.content)
                        .textFieldStyle(CreateTextField(title: "인물설명"))
                        .focused($isTextFieldFocused)
                        .padding(.bottom, 30)
                    
                    VStack(alignment: .leading) {
                        Text("시나리오 내용")
                            .font(.pretendard(.semibold, size: 16))
                            .foregroundStyle(Color(hex: "7D848A"))
                        
                        TextEditor(text: $viewModel.prompt)
                            .customStyleEditor(placeholder: placeholder, userInput: $scenarioText)
                    }
                }
                CreateButton(action: {
                              viewModel.postScenario { success in
                                  isSuccess = success
                                  isLoading = false 
                                  if success {
                                      print("시나리오 업로드 성공")
                                      alertOn = true
                                  } else {
                                      print("시나리오 업로드 실패")
                                  }
                              }
                          }, isLoading: $isLoading, isSuccess: $isSuccess)
                       
                
                               
                .padding(.top, 10)
            }
            .padding(.horizontal, 17)
            .alert(isPresented: $alertOn) {
                Alert(title: Text("업로드 완료!"),message: Text("시나리오가 업로드 되었어요."),dismissButton: .default(Text("확인"), action: {
                    dismiss()
                }))
                
            }
        }
    }
}

#Preview {
    CreateView()
}
