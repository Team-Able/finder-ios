//
//  KeyboardResponder.swift
//  Finder
//
//  Created by dgsw30 on 12/13/24.
//


import SwiftUI
import Combine

//MARK: 키보드 방지 함수
class KeyboardResponder: ObservableObject {
    @Published var keyboardHeight: CGFloat = 0
    private var cancellable: AnyCancellable?

    init() {
        cancellable = NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
            .merge(with: NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification))
            .compactMap { notification in
                guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
                    return 0
                }
                return frame.origin.y < UIScreen.main.bounds.height ? frame.height : 0
            }
            .assign(to: \.keyboardHeight, on: self)
    }

    deinit {
        cancellable?.cancel()
    }
}
