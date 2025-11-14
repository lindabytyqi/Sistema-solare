import SwiftUI

// 1. Modello per il JSON di risposta
struct APOD: Decodable {
    let url: String
    let title: String
    let explanation: String
}

// 2. ViewModel che fa il fetch dell’APOD
class APODViewModel: ObservableObject {
    @Published var apod: APOD?
    @Published var errorMessage: String?

    private let apiKey = "7mcnzjS2pAluJZlNUjGxOY74dIX3fGRKsklpkQqm"  // metti la tua chiave qui

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

// 3. InfoView che mostra la foto della NASA
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

                    // Carica l’immagine da URL
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
                    ProgressView("Loading...")
                        .foregroundColor(.white)
                        .padding()
                }

                Spacer()
            }
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .onAppear {
            viewModel.fetchAPOD()
        }
    }
}
