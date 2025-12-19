//Autore: Linda Bytyqi
//Descrizione: gestione API APOD
//Data: 09.09.2025
import SwiftUI 

// modello per il JSON di risposta
struct APOD: Decodable {
    let url: String
    let title: String
    let explanation: String
}

// ViewModel che fa il fetch dell’APOD
class APODViewModel: ObservableObject {
    @Published var apod: APOD?
    @Published var errorMessage: String?

    private let apiKey = "7mcnzjS2pAluJZlNUjGxOY74dIX3fGRKsklpkQqm"  // API Key

    func fetchAPOD() {
        let urlString = "https://api.nasa.gov/planetary/apod?api_key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            self.errorMessage = "URL non valido"
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Error: \(error.localizedDescription)"
                }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    self.errorMessage = "Nessun dato ricevuto"
                }
                return
            }
            do {
                let decoded = try JSONDecoder().decode(APOD.self, from: data)
                DispatchQueue.main.async {
                    self.apod = decoded
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Errore di decodifica: \(error)"
                }
            }
        }.resume()
    }
}

//InfoView che mostra la foto della NASA
struct InfoView: View {
    @StateObject private var viewModel = APODViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if let apod = viewModel.apod {
                    Text(apod.title)
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding()

                    // carica l’immagine da URL
                    AsyncImage(url: URL(string: apod.url)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()  // mostra un caricamento finché non arriva l’immagine
                    }
                    .frame(maxWidth: .infinity)
                    .padding()

                    Text(apod.explanation)
                        .foregroundColor(.white)
                        .padding()
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    Image("Loading")
                        .resizable()
                        .scaledToFill()
                       // .frame(maxWidth: 700, maxHeight: 900)
                        .background(.white)
                    
                    Text("Loading picture of the day...")
                        .foregroundColor(.white)
                }
                Spacer()
            }
            
        }
        .navigationTitle("Picture of the Day")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .onAppear {
            viewModel.fetchAPOD()
        }
    }
}
