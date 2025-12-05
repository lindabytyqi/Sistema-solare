//Autore: Linda Bytyqi
//Descrizione: struttura dei dati per i pianeti
//Data: 09.09.2025
import Foundation

struct Video: Codable {
    let url: String
    let title: String?
}

struct Planet: Codable {
    let name: String
    let details: [String]
    let video: Video?
}
