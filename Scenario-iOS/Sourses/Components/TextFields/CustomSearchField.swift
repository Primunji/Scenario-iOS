//
//  CustomSearchField.swift
//  Scenario
//
//  Created by dgsw07 on 3/5/25.
//

import SwiftUI

struct CustomSearchField: View {
    @State  var placeholder: String
    @Binding var searchText: String
    
    var body: some View {
        GeometryReader { scale in
            VStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: scale.size.width * 1,height: 45)
                    .foregroundColor(Color(hex: "E8EBF0"))
                    .overlay {
                        HStack(spacing: 10) {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 18))
                                .foregroundColor(Color(hex: "7D848A"))
                            
                            TextField(placeholder, text: $searchText)
                                .tint(Color(hex: "7D848A"))
                                .font(.pretendard(.semibold, size: 18))
                                .foregroundColor(.black)
                            
                            Spacer()
                        }
                        .padding(.horizontal, 10)
                    }
            }
            .frame(width: scale.size.width, height: scale.size.height)
        }
        .frame(height: 45)
    }
}

