/*
Autore: Linda Bytyqi
Descrizione: Creazione della pagina iniziale
Data: 09.09.2025
*/

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack { //Permette di navigare
            ZStack {
                //Immagine di sottofondo
                Image("Background") 
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    //Scritta iniziale
                    Text("Welcome to Nebula!")
                        .foregroundColor(.white)
                        .bold()
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                    
                    NavigationLink(destination: HomeView()) { //Quando viene schiacciato il frame si va nella HomeView
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

//Anteprima interattiva della ContentView
#Preview {
    ContentView()
}
