import Foundation

struct YouTubeSearchResponse: Codable {
    let items: [TrailerVideo]
}

struct TrailerVideo: Codable {
    let id: IdVideoElement
    let etag: String
    let kind: String
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
