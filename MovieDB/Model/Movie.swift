import Foundation

struct Movie: Codable {
    let id: Int
    let mediaType: String?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case mediaType = "media_type"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview = "overview"
        case popularity = "popularity"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title = "title"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

struct MovieResponse: Codable {
    let results: [Movie]
}
