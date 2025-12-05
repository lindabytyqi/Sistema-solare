//Autore: Linda Bytyqi
//Descrizione: gestione API Moon Phase + pagina dedicata alla Luna
//Data: 09.09.2025
import SwiftUI

struct APIVerveMoonResponse: Decodable {
    struct InnerData: Decodable {
        let phase: String
    }
    let status: String
    let data: InnerData?
    let error: String?  // eventuale errore API
}

struct MoonDetailView: View {
    @State private var phase: String = "Loading..."
    @State private var errorMessage: String? = nil
    
    // limiti per schermi grandi -> MacOS
    let maxLabelFontSize: CGFloat = 40     // dimensione max per il testo 
    let maxPhaseFontSize: CGFloat = 60     // dimensione max per la fase lunare
    let maxContentWidth: CGFloat = 800     // larghezza max del contenuto su iPad/Mac
    
    var body: some View {
        GeometryReader { geo in
            // calcolo del fattore di scala basato sul minimo tra larghezza e altezza
            let scaleFactor = min(geo.size.width, geo.size.height)
            
            ZStack {
                // sfondo stellato
                Image("sfondo2")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack {
                        Image("Moon")
                            .resizable()
                            .scaledToFit()
                        // dimensionamento basato sul nuovo scaleFactor (più stabile)
                            .frame(width: scaleFactor * 0.4, height: scaleFactor * 0.4)
                            .shadow(radius: 10)
                            .overlay(
                                Circle()
                                //adattamento anche dello spessore del bordo
                                    .stroke(Color.white.opacity(0.3), lineWidth: scaleFactor * 0.01)
                                    .blur(radius: scaleFactor * 0.005)
                            )
                        
                        Text("Current Moon Phase")
                            .font(.system(size: min(scaleFactor * 0.05, maxLabelFontSize), weight: .bold))
                            .foregroundColor(.white)
                        
                        //fase della Luna dall'API
                        Text(phase)
                            .font(.system(size: min(scaleFactor * 0.07, maxPhaseFontSize), weight: .semibold))
                            .foregroundColor(.yellow)
                        
                        // eventuale messaggio di errore
                        if let e = errorMessage {
                            Text("Error: \(e)")
                                .foregroundColor(.red)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        
                        // calendario lunare
                        Image("MoonCalendar")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity, maxHeight: geo.size.height * 0.4)
                            .shadow(radius: 5)
                        
                        Spacer()
                    }
                    .frame(maxWidth: maxContentWidth) 
                }
                .padding(.horizontal, scaleFactor * 0.05)
                .padding(.top, geo.size.height * 0.05)
            }
        }
        .navigationTitle("Moon")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            fetchMoonPhase()
        }
    }
    
    func fetchMoonPhase() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        let today = formatter.string(from: Date())
        
        guard var components = URLComponents(string: "https://api.apiverve.com/v1/moonphases") else {
            self.errorMessage = "Invalid URL"
            return
        }
        components.queryItems = [
            URLQueryItem(name: "date", value: today)
        ]
        guard let url = components.url else {
            self.errorMessage = "Invalid URL components"
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("afd1bab3-b95c-45ef-a9cd-feec76847f0f", forHTTPHeaderField: "X-API-Key")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { data, _, err in
            if let err = err {
                DispatchQueue.main.async {
                    self.errorMessage = "Request error: \(err.localizedDescription)"
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.errorMessage = "No data received"
                }
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(APIVerveMoonResponse.self, from: data)
                DispatchQueue.main.async {
                    if let d = decoded.data {
                        self.phase = d.phase
                    } else {
                        self.errorMessage = "API error: \(decoded.error ?? "unknown")"
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Decoding error: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}
