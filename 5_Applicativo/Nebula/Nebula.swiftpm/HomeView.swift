//Autore: Linda Bytyqi
//Descrizione: creazione del Sistema Solare, dello zoom, della Luna e della NavBar
//Data: 09.09.2025
import SwiftUI

struct HomeView: View {
    let planetsData = PlanetData.load() //prende i dati dei pianeti da PlanetData
    
    //array con tutti i pianeti
    let orbitals = [
        //("nome pianeta", raggio orbitale, dimensione, velocità)
        ("Mercury", 80.0, 4.0, 20.0),
        ("Venus", 110.0, 6.0, 30.0),
        ("Earth", 140.0, 8.0, 50.0),
        ("Mars", 170.0, 10.0, 30.0),
        ("Jupiter", 200.0, 12.0, 45.0),
        ("Saturn", 230.0, 14.0, 60.0),
        ("Uranus", 260.0, 16.0, 35.0),
        ("Neptun", 290.0, 18.0, 30.0)
    ]
    //scala della pagina
    @State private var scale: CGFloat = 0.7
    @State private var lastScale: CGFloat = 0.7
    
    var body: some View {
        ZStack {
            
            // se la scala è < 0.7, mostra la galassia
            if scale < 0.7 {
                Image("Galaxy")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            } else {
                // se no il Sistema Solare
                Image("Background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                ZStack {
                    // immagine del Sole
                    Image("Sun")
                        .resizable()
                        .frame(width: 100, height: 100)
                    
                    // mostra i pianeti e la navigaziome
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
                    
                    // creazione della Luna
                    NavigationLink(destination: MoonDetailView()) { //quando la premi porta alla sus pagina di informazioni
                        Image("Moon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 90)
                            .shadow(radius: 10)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .offset(x: 220, y: -270)
                }
                .scaleEffect(scale)
            }
        }
        // zoom fluido
        .gesture(
            MagnificationGesture()
                .onChanged { value in
                    let delta = value / lastScale
                    scale *= delta
                    scale = max(0.3, min(scale, 3.0))
                    lastScale = value
                }
                .onEnded { _ in
                    lastScale = 1.0
                }
        )
        //NavBar
        .navigationTitle("Solar System")
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                NavigationLink("Picture of the Day", destination: InfoView())
            }
        }
    }
}
