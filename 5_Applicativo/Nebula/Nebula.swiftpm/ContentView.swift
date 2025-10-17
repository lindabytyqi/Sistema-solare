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
    // Lista dei pianeti
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
            
            ForEach(planets, id: \.0) { planet in
                let (name, radius, duration, size) = planet
                NavigationLink(destination: PlanetDetailView(
                    planetName: name,
                    planetDetails: planetDetails[name]?.1 ?? []
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
                        .padding(.top, 40)
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

let planetDetails: [String: (String, [String])] = [
    "Mercury": ("Mercury", [
        """
         Mercurio è il pianeta più piccolo del Sistema Solare e il più vicino al Sole.  
         È noto per essere il più veloce a orbitare intorno alla sua stella, completando un’orbita in soli 88 giorni terrestri.
         La sua superficie è ricoperta di crateri, simile a quella della Luna, e presenta forti escursioni termiche: durante il giorno può raggiungere +427°C, mentre di notte scende fino a −173°C, a causa della quasi totale assenza di atmosfera.
        Mercurio è un pianeta roccioso, con un enorme nucleo di ferro che costituisce circa l’80% della sua massa, avvolto da un mantello di silicati e una crosta esterna.
        """,
        """
        Caratteristiche fisiche
        • Distanza dal Sole: circa 58 milioni di km  
        • Velocità orbitale: 50 km/s  
        • Periodo orbitale: 88 giorni terrestri  
        • Periodo di rotazione: 59 giorni terrestri  
        • Massa: 3,3 × 10²³ kg (≈ 6% della massa terrestre)  
        • Raggio: 2.440 km  
        • Densità: 5,43 volte quella dell’acqua  
        • Lune: nessuna  
        • Composizione: 80% nucleo ferroso, mantello di silicati e crosta esterna  
        • Superficie: ricoperta di crateri e scarpate dovute al raffreddamento del pianeta  
        • Atmosfera: estremamente sottile, quasi assente
        """,
        """
Esplorazione
L'esplorazione di Mercurio è stata effettuata da poche missioni spaziali. 
 • Mariner 10: La prima sonda della NASA a visitare il pianeta tra il 1974 e il 1975, mappando quasi metà della sua superficie.
 • MESSENGER: Un'altra sonda della NASA che ha orbitato intorno a Mercurio dal 2011 al 2015, fornendo una mappatura completa della superficie.
 • BepiColombo: Una missione congiunta tra l'Agenzia Spaziale Europea (ESA) e l'Agenzia Giapponese per l'Esplorazione Aerospaziale (JAXA), partita nel 2018. L'ingresso in orbita di Mercurio è previsto per il 2025.
"""
  ]),      
        "Venus": ("Venus", [
        """
         Venere è un pianeta roccioso, il "gemello" della Terra per dimensioni, ma con condizioni estreme: è il pianeta più caldo del sistema solare (circa 465 − 475°C) a causa della sua densa atmosfera di anidride carbonica. Ha una superficie con migliaia di vulcani e crateri, è avvolto da nubi di acido solforico e ruota molto lentamente all'indietro (rotazione retrograda), con un giorno più lungo di un anno. È anche l'oggetto più luminoso del cielo notturno dopo la Luna
        """,
        
        """
        Caratteristiche fisiche:
          • Dimensioni e massa: È molto simile alla Terra, con un diametro circa il 95% di quello terrestre e una massa circa l'87% di quella terrestre. 
          • Atmosfera: È composta per la maggior parte di anidride carbonica, con una pressione superficiale 92-93 volte superiore a quella terrestre, equivalente a quella che si trova a circa 900 metri di profondità nel mare.  
          • Temperatura: La temperatura media superficiale è di circa 465 - 475°C, abbastanza alta da fondere il piombo. 
          • Superficie: È caratterizzata da migliaia di vulcani, vaste pianure vulcaniche e numerosi crateri da impatto.
          • Rotazione: Ha una rotazione lentissima e retrograda, in senso opposto alla maggior parte degli altri pianeti, impiegando 243 giorni terrestri per un giro completo su se stesso.
          • Giorno e anno: Un giorno venusiano dura 243 giorni terrestri, mentre un anno dura circa 225 giorni terrestri, rendendo il giorno più lungo dell'anno. 
        """,
        
        """
Condizioni e ambiente
 • Nubi: Un denso strato di nubi di acido solforico riflette circa il 76% della luce solare, rendendo Venere molto luminoso
 • Pressione e atmosfera: L'alta pressione e l'anidride carbonica rendono la superficie infernale e inospitale per la vita, come la conosciamo
 • Acqua: Attualmente non c'è acqua liquida sulla superficie, ma in passato potrebbe averne avuta
 • Osservazione: La sua atmosfera densa impedisce la visione diretta della superficie con i telescopi ottici, ma le missioni spaziali hanno potuto mapparla usando il radar
""",
"""
Curiosità
 • "Pianeta gemello": Viene spesso definito il "gemello della Terra" per via delle dimensioni simili, ma le condizioni attuali sono drasticamente diverse
 • Vulcani attivi: Studi recenti suggeriscono che l'attività vulcanica su Venere potrebbe essere ancora in corso
 • Rotazione retrograda: La rotazione in senso opposto rispetto agli altri pianeti potrebbe essere dovuta a un gigantesco impatto subito in passato
"""
        
    ])

]

#Preview {
    ContentView()
}
