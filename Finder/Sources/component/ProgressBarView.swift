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
                .foregroundColor(Color.maincolor)
                .animation(.linear, value: progress)
        }
        .cornerRadius(3)
    }
}

#Preview {
    ProgressBar()
}



//struct ContentView: View {
//
//    var body: some View {
//        VStack {
//            ProgressBar(progress: progress)
//                .frame(height: 6) // 진행 표시 바 높이
//
////            Button("Increase Progress") {
////                if progress < 1.0 {
////                    progress += 0.35
////                }
////            }
//            .padding()
//        }
//        .padding()
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
