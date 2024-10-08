import SwiftUI

struct ProgressBar: View {
    enum Progresscolor {
        case one
        case two
        case three
        case four
        
        var fillcolor: Int {
            switch self {
            case .one:
                return 1
            case .two:
                return 2
            case .three:
                return 3
            case .four:
                return 4
            }
        }
    }
    var progress: Progresscolor
    var body: some View {
        HStack {
            ForEach(0..<4) { index in
                Circle()
                    .fill(index < progress.fillcolor ? Color.primary500 : Color.progress)
                    .frame(width: 8, height: 8)
            }
        }
    }
}
