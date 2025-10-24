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
