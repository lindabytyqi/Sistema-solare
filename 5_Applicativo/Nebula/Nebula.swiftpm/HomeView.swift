/*
Autore: Linda Bytyqi
Descrizione: Creazione del Sistema Solare, dello zoom, della Luna e della NavBar
Data: 09.09.2025
*/
import SwiftUI

struct HomeView: View {
    let planetsData = PlanetData.load() //Prende i dati da PlanetData
    
    //Array con tutti i pianeti
    let orbitals = [
        //("Nome pianeta", raggio orbitale, dimensione, velocità)
        ("Mercury", 80.0, 4.0, 20.0), 
        ("Venus", 110.0, 6.0, 30.0),
        ("Earth", 140.0, 8.0, 50.0),
        ("Mars", 170.0, 10.0, 30.0),
        ("Jupiter", 200.0, 12.0, 45.0),
        ("Saturn", 230.0, 14.0, 60.0),
        ("Uranus", 260.0, 16.0, 35.0),
        ("Neptun", 290.0, 18.0, 30.0)
    ]
    
    //Usati per gestire lo zoom
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            
            //se la scala < 0.7, mostra la galassia
            if scale < 0.7 {
                Image("Galaxy")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            } else {
                //se no il sistema solare
                Image("Background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
               
                Image("Sun")
                    .resizable()
                    .frame(width: 100, height: 100)
                
                //Mostra pianeti e navigazione
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
                
                //Creazione della Luna
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
        
        .gesture(
            MagnificationGesture()
                .onChanged { value in
                    scale = lastScale * value
                }
                .onEnded { _ in
                    lastScale = scale
                }
        )
        .scaleEffect(scale >= 0.7 ? scale : 1.0) 
        
        //NavBar
        .navigationTitle("Solar System")
        .toolbar {
            ToolbarItemGroup(placement: .topBar) {
                NavigationLink("Home", destination: HomeView())
                Spacer()
                NavigationLink("Information of the day", destination: InfoView())
            }
        }
    }
}
