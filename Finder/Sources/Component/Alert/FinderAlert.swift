import SwiftUI

struct FinderAlert: ViewModifier {
    @Binding var isPresented: Bool
    let message: String?
    let text: String
    
    func body(content: Content) -> some View {
        content
            .alert(text, isPresented: $isPresented, actions: {
                Button("확인", role: .cancel) {}
            }, message: {
                Text(message ?? "")
            })
    }
}

extension View {
    func finderAlert(isPresented: Binding<Bool>, message: String?, text: String) -> some View {
        self.modifier(FinderAlert(isPresented: isPresented, message: message, text: text))
    }
}
