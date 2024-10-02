import SwiftUI

struct ProgressBar: View {
    @State private var progress: CGFloat = 0.35
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            Rectangle()
                .frame(width: 180, height: 8)
                .opacity(0.3)
                .foregroundColor(Color.gray)
            
            
            Rectangle()
                .frame(width: 180 * progress, height: 8)
                .foregroundColor(Color.textfield)
                .animation(.linear, value: progress)
        }
        .cornerRadius(3)
    }
}

#Preview {
    ProgressBar()
}
