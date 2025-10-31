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
                    Text("Benvenuto su Nebula!")
                        .foregroundColor(.white)
                        .bold()
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                    
                    NavigationLink(destination: HomeView()) {
                        Text("Scopri il mondo dell’universo")
                            .foregroundColor(.black)
                            .font(.title2)
                            .frame(width: 350, height: 50)
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
