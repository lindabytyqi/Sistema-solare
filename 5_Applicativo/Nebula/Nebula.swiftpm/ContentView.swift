import SwiftUI       

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Image("Background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    Text("Benvenuto su Nebula!")
                        .foregroundColor(.white)
                        .bold()
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                    
                    NavigationLink(destination: HomeView()) {
                        Text("Scopri il mondo dell'universo")
                            .foregroundColor(.black)
                            .font(.title2)
                            .frame(width: 350, height: 50)
                            .background(Color.white)
                            .cornerRadius(25)
                            .shadow(radius: 5)
                            .padding()
                    }
                }
            }
        }
    }
}

struct HomeView: View {
    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            Image("Sun")
                .resizable()
                .frame(width: 100, height: 100)
            
            NavigationLink(destination: PlanetDetailView(planetName: "Mercury")) {
                PlanetView(imageName: "Mercury", radius: 80, duration: 4, size: 20)
            }
            
            NavigationLink(destination: PlanetDetailView(planetName: "Venus")) {
                PlanetView(imageName: "Venus", radius: 110, duration: 6, size: 30)
            }
            
            NavigationLink(destination: PlanetDetailView(planetName: "Earth")) {
                PlanetView(imageName: "Earth", radius: 140, duration: 8, size: 50)
            }
            
            NavigationLink(destination: PlanetDetailView(planetName: "Mars")) {
                PlanetView(imageName: "Mars", radius: 170, duration: 10, size: 30)
            }
            
            NavigationLink(destination: PlanetDetailView(planetName: "Jupiter")) {
                PlanetView(imageName: "Jupiter", radius: 200, duration: 12, size: 45)
            }
            
            NavigationLink(destination: PlanetDetailView(planetName: "Saturn")) {
                PlanetView(imageName: "Saturn", radius: 230, duration: 14, size: 60)
            }
            
            NavigationLink(destination: PlanetDetailView(planetName: "Uranus")) {
                PlanetView(imageName: "Uranus", radius: 260, duration: 16, size: 35)
            }
            
            NavigationLink(destination: PlanetDetailView(planetName: "Neptun")) {
                PlanetView(imageName: "Neptun", radius: 290, duration: 18, size: 30)
            }
        }
    
        VStack {
            HStack {
                Spacer()
                Image("Moon")
                    .resizable()
                    .frame(width: 100, height: 50)
                    .padding()
            }
            Spacer()
        }
    }
}

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
struct PlanetDetailView: View {
    var planetName: String
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Benvenuto su \(planetName)")
                .font(.largeTitle)
                .bold()
                .padding()
            
            Image(planetName)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            
            Text("Qui puoi inserire curiosità e informazioni su \(planetName).")
                .multilineTextAlignment(.center)
                .padding()
        }
        .navigationTitle(planetName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
