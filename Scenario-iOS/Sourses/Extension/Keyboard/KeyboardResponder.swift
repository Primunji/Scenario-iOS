//
//  KeyboardResponder.swift
//  Scenario-iOS
//
//  Created by dgsw07 on 3/10/25.
//
import Combine
import UIKit

class KeyboardResponder: ObservableObject {
    @Published var keyboardHeight: CGFloat = 0
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .merge(with: NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification))
            .sink { notification in
                if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                    self.keyboardHeight = keyboardFrame.height
                }
            }
            .store(in: &cancellables)

        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .sink { _ in
                self.keyboardHeight = 0
            }
            .store(in: &cancellables)
    }
}
