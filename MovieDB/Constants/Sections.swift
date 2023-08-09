import Foundation

enum HomeSections: CaseIterable {
    case trending
    case popular
    case topRated
    case discover
    
    func getTitle() -> String {
        switch self {
        case .trending:
            return "Trending"
        case .popular:
            return "Popular"
        case .topRated:
            return "Top Rated"
        case .discover:
            return "Discover"
        }
    }
}
