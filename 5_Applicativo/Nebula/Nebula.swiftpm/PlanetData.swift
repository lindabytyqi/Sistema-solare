/*
Autore: Linda Bytyqi
Descrizione: Caricamento dati JSON dinamico
Data: 09.09.2025
*/
import Foundation

//Controlli file JSON

class PlanetData {
    static func load() -> [Planet] {
        guard let url = Bundle.main.url(forResource: "json", withExtension: "json") else {
            print("Errore: file json.json non trovato")
            return []
        }
        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode([Planet].self, from: data)
            return decoded
        } catch {
            print("Errore nel caricamento JSON: \(error)")
            return []
        }
    }
}
