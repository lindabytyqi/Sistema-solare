import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Image("Background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    Text("Welcome to Nebula!")
                        .foregroundColor(.white)
                        .bold()
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                    
                    NavigationLink(destination: HomeView()) {
                        Text("Explore space, one planet at a time")
                            .foregroundColor(.black)
                            .font(.title2)
                            .frame(width: 450, height: 50)
                            .background(Color.white)
                            .cornerRadius(25)
                            .shadow(radius: 5)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
