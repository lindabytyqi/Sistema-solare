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
    
    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            Image("Sun")
                .resizable()
                .frame(width: 100, height: 100)
            
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
