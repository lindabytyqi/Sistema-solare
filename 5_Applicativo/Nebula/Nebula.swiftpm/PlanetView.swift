import SwiftUI

struct PlanetView: View {
    var imageName: String
    var radius: CGFloat
    var duration: Double
    var size: CGFloat
    
    @State private var angle: Double = 0
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                .frame(width: radius * 2, height: radius * 2)
            
            Image(imageName)
                .resizable()
                .frame(width: size, height: size)
                .offset(x: radius)
                .rotationEffect(.degrees(angle))
                .onAppear {
                    withAnimation(.linear(duration: duration).repeatForever(autoreverses: false)) {
                        angle = 360
                    }
                }
        }
    }
}
