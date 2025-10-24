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

struct HomeView: View {
    // Carica i dati dal file json.json
    let planetsData = PlanetData.load()
    
    // Parametri orbitali (per animazioni e distanze)
    let planets = [
        ("Mercury", 80.0, 4.0, 20.0),
        ("Venus", 110.0, 6.0, 30.0),
        ("Earth", 140.0, 8.0, 50.0),
        ("Mars", 170.0, 10.0, 30.0),
        ("Jupiter", 200.0, 12.0, 45.0),
        ("Saturn", 230.0, 14.0, 60.0),
        ("Uranus", 260.0, 16.0, 35.0),
        ("Neptune", 290.0, 18.0, 30.0)
    ]
    
    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            Image("Sun")
                .resizable()
                .frame(width: 100, height: 100)
            
            // Ciclo dei pianeti con dati dal JSON
            ForEach(planets, id: \.0) { planet in
                let (name, radius, duration, size) = planet
                let detailsFromJSON = planetsData.first(where: { $0.name == name })?.details ?? []
                
                NavigationLink(destination: PlanetDetailView(
                    planetName: name,
                    planetDetails: detailsFromJSON
                )) {
                    PlanetView(imageName: name, radius: radius, duration: duration, size: size)
                }
                .buttonStyle(PlainButtonStyle())
            }
            
            VStack {
                HStack {
                    Spacer()
                    Image("Moon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 70)
                        .padding(.top, 10)
                        .padding(.trailing, 20)
                        .shadow(radius: 10)
                }
                Spacer()
            }
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
    let planetDetails: [String]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Benvenuto su \(planetName)")
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                    .minimumScaleFactor(0.7)
                
                Image(planetName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 250)
                    .shadow(radius: 10)
                    .padding(.bottom, 10)
                
                VStack(alignment: .leading, spacing: 15) {
                    ForEach(planetDetails, id: \.self) { paragraph in
                        Text(paragraph)
                            .font(.system(size: 18, design: .rounded))
                            .multilineTextAlignment(.leading)
                            .lineSpacing(6)
                            .padding(.horizontal, UIDevice.current.userInterfaceIdiom == .pad ? 80 : 20)
                            .minimumScaleFactor(0.8)
                    }
                }
                .padding(.bottom, 40)
            }
            .frame(maxWidth: .infinity)
        }
        .background(
            Image("sfondo2")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
        .foregroundColor(.white)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ContentView()
}
