import SwiftUI

//MARK: 색깔지정함수
struct TextColor {
    let color: Color
    func attributedString(for fullText: String, targetWord: String) -> AttributedString {
        var attributedString = AttributedString(fullText)
        
        if let range = attributedString.range(of: targetWord) {
            attributedString[range].foregroundColor = color
        }
        
        return attributedString
    }
}
