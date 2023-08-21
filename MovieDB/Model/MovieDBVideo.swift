import Foundation

struct MovieDBVideo: Codable {
    let name: String
    let key: String
    let site: String
    let size: Int
    let type: String
    let official: Bool
    let publishedAt: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case key
        case site
        case size
        case type
        case official
        case publishedAt = "published_at"
        case id
    }
}
