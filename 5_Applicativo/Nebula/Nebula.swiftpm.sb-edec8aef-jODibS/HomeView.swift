import SwiftUI

struct HomeView: View {
    let planetsData = PlanetData.load()
    
    let orbitals = [
        ("Mercury", 80.0, 4.0, 20.0),
        ("Venus", 110.0, 6.0, 30.0),
        ("Earth", 140.0, 8.0, 50.0),
        ("Mars", 170.0, 10.0, 30.0),
        ("Jupiter", 200.0, 12.0, 45.0),
        ("Saturn", 230.0, 14.0, 60.0),
        ("Uranus", 260.0, 16.0, 35.0),
        ("Neptun", 290.0, 18.0, 30.0)
    ]
    
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            
            // 🌌 Se zoom molto basso → mostra solo la galassia
            if scale < 0.7 {
                Image("Galaxy")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            } else {
                
                // 🌞 Sfondo normale del sistema solare
                Image("Background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                // ☀️ Sole
                Image("Sun")
                    .resizable()
                    .frame(width: 100, height: 100)
                
                // 🌍 Pianeti in orbita
                ForEach(planetsData, id: \.name) { planet in
                    if let orbital = orbitals.first(where: { $0.0 == planet.name }) {
                        NavigationLink(destination: PlanetDetailView(planet: planet)) {
                            PlanetView(imageName: planet.name,
                                       radius: orbital.1,
                                       duration: orbital.2,
                                       size: orbital.3)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                
                // 🌙 Luna fissa
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
        
        // 🔍 Zoom
        .gesture(
            MagnificationGesture()
                .onChanged { value in
                    scale = lastScale * value
                }
                .onEnded { _ in
                    lastScale = scale
                }
        )
        .scaleEffect(scale >= 0.7 ? scale : 1.0) // evita che la galassia si rimpicciolisca
        
        .navigationTitle("Solar System")
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                NavigationLink("Home", destination: HomeView())
                Spacer()
                NavigationLink("Information of the day", destination: InfoView())
            }
        }
    }
}
