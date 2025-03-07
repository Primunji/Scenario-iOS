//
//  CustomTextEditorStyle.swift
//  Senario
//
//  Created by dgsw07 on 3/5/25.
//

import SwiftUI

struct CustomTextEditorStyle: ViewModifier {
    
    let placeholder: String
    @Binding var text: String
    
    func body(content: Content) -> some View {
        GeometryReader { scale in
            content
                .padding()
                .background(alignment: .topLeading) {
                    if text.isEmpty {
                        Text(placeholder)
                            .lineSpacing(10)
                            .padding(20)
                            .padding(.top, 2)
                            .font(.system(size: 14))
                            .foregroundColor(Color(UIColor.systemGray2))
                    }
                }
                .frame(width: scale.size.width * 1, height: 250)
                .textInputAutocapitalization(.none)
                .autocorrectionDisabled()
                .background(Color(hex: "EDEEF1"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .scrollContentBackground(.hidden)
                .font(.system(size: 14))
                .overlay(alignment: .bottomTrailing) {
                    Text("\(text.count) / 200")
                        .font(.system(size: 12))
                        .foregroundColor(Color(hex: "7D848A"))
                        .padding(.trailing, 15)
                        .padding(.bottom, 15)
                        .onChange(of: text) { newValue in
                            if newValue.count > 200 {
                                text = String(newValue.prefix(200))
                            }
                        }
                }
        }
    }
}

extension TextEditor {
    func customStyleEditor(placeholder: String, userInput: Binding<String>) -> some View {
        self.modifier(CustomTextEditorStyle(placeholder: placeholder, text: userInput))
    }
}

