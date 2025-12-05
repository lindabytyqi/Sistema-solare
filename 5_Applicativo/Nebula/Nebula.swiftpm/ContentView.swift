//Autore: Linda Bytyqi
//Descrizione: creazione della pagina iniziale
//Data: 09.09.2025
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack { //permette di navigare
            ZStack {
                //immagine di sfondo
                Image("Background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    //scritta iniziale
                    Text("Welcome to Nebula!")
                        .foregroundColor(.white)
                        .bold()
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                    
                    NavigationLink(destination: HomeView()) { //quando viene cliccato il frame si va nella HomeView
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
//anteprima interattiva della ContentView
#Preview {
    ContentView()
}
