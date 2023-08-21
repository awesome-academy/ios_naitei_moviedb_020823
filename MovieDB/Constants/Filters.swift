import Foundation

struct Filters {
    static let baseFilter = "&language=en-US"
    static let basicFilter = "&language=en-US&page=1"
    static let advancedFilter1 = "&language=en-US&sort_by=popularity.desc&include_adult=false"
    static let advancedFilter2 = "&include_video=false&page=1&with_watch_monetization_types=flatrate"
    static let advancedFilter = advancedFilter1 + advancedFilter2
}
