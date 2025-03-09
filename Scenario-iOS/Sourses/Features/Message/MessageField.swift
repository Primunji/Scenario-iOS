//
//  MessageField.swift
//  Scenario-iOS
//
//  Created by dgsw07 on 3/9/25.
//

import SwiftUI

struct MessageField: View {
    @Binding var message: String
    @Binding var thread_id: String
    var action: () -> Void  // Remove @Binding here
    var body: some View {
        GeometryReader { scale in
            Rectangle()
                .stroke(lineWidth: 1)
                .foregroundStyle(.black.opacity(0.1))
                .overlay {
                VStack {
                    Capsule()
                        .frame(width: scale.size.width * 0.95,height: 50)
                        .foregroundStyle(Color(hex: "#F3F4F5"))
                        .overlay {
                            TextField("대화 내용을 입력해주세요.", text: $message)
                                .padding(.leading,15)
                                .textFieldStyle(MessageTextFieldStyle(text:$message, threadId: $thread_id, action:action))
                            
                        }
                }
            }
            .frame(width: scale.size.width, height: scale.size.height)
        }
        
        .frame(height: 98)
        .background(Color.white)
    }
}



struct MessageTextFieldStyle: TextFieldStyle {
    @Binding var text: String
    @Binding var threadId: String
    var action: () -> Void  // Remove @Binding here


    func _body(configuration: TextField<Self._Label>) -> some View {
        GeometryReader { scale in
            VStack {
                HStack {
                    configuration
                        .font(.pretendard(.medium, size: 14))
                        .foregroundStyle(Color(hex:"#7D848A"))
                    Button {
                        action()
                    } label: {
                        Image(systemName: "paperplane.circle.fill")
                            .font(.system(size: 35))
                            .padding(.trailing,5)
                            .foregroundStyle(Color(hex: "2B7FFF"))
                    }

                }
            }
            .frame(width: scale.size.width,height: scale.size.height)
        }
        .frame(height: 17)
    }
}

//
//struct CustomTextField: TextFieldStyle {
//    let height: CGFloat
//    func _body(configuration: TextField<Self._Label>) -> some View {
//        GeometryReader { scale in
//            VStack {
//                ZStack {
//                    RoundedRectangle(cornerRadius: 10)
//                        .foregroundColor(Color(hex: "EDEEF1"))
//                        .frame(width: scale.size.width * 1 ,height: height)
//                    configuration
//                        .font(.pretendard(.semibold, size: 16))
//                        .foregroundColor(Color(hex: "7D848A"))
//                        .padding()
//                }
//            }
//            .frame(width: scale.size.width,height: scale.size.height)
//        }
//        .frame(height: height)
//    }
//}
