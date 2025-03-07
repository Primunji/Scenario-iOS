//
//  AuthBackButton.swift
//  Senario
//
//  Created by dgsw07 on 3/5/25.
//

import SwiftUI

struct AuthBackButton: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "arrow.backward")
                .font(.system(size: 24))
                .foregroundColor(.black)
            
        }

    }
}

#Preview {
    AuthBackButton()
}
