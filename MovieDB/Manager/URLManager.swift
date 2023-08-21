import Foundation

class URLManager {
    static private var keys = ProductKeys.shared
    
    enum URLType {
        case trending
        case topRated
        case popular
        case upcoming
        case discover
    }
    
    static func getURL(for type: URLType) -> NSMutableURLRequest? {
        switch type {
        case .trending:
            let request = NSMutableURLRequest(url: NSURL(string: Constants.baseURL + EndPoints.trendingEndPoint)! as URL,
                cachePolicy: .useProtocolCachePolicy,
                timeoutInterval: 10.0)
            initRequest(request: request)
            return request
        case .topRated:
            let request = NSMutableURLRequest(url: NSURL(string: Constants.baseURL + EndPoints.topRatedEndPoint + Filters.basicFilter)! as URL,
                cachePolicy: .useProtocolCachePolicy,
                timeoutInterval: 10.0)
            initRequest(request: request)
            return request
        case .popular:
            let request = NSMutableURLRequest(url: NSURL(string: Constants.baseURL + EndPoints.popularEndPoint + Filters.basicFilter)! as URL,
                cachePolicy: .useProtocolCachePolicy,
                timeoutInterval: 10.0)
            initRequest(request: request)
            return request
        case .upcoming:
            let request = NSMutableURLRequest(url: NSURL(string: Constants.baseURL + EndPoints.upcomingEndPoint + Filters.basicFilter)! as URL,
                cachePolicy: .useProtocolCachePolicy,
                timeoutInterval: 10.0)
            initRequest(request: request)
            return request
        case .discover:
            let request = NSMutableURLRequest(url: NSURL(string: Constants.baseURL + EndPoints.discoverEndPoint + Filters.advancedFilter)! as URL,
                cachePolicy: .useProtocolCachePolicy,
                timeoutInterval: 10.0)
            initRequest(request: request)
            return request
        }
    }
    
    static func getURL(for searchKey: String) -> NSMutableURLRequest? {
          let request = NSMutableURLRequest(url: NSURL(string: Constants.baseURL + EndPoints.searchEndPoint + "&query=\(searchKey)")! as URL,
              cachePolicy: .useProtocolCachePolicy,
              timeoutInterval: 10.0)
            initRequest(request: request)
            return request
    }
    
    static func getURL(movieID: Int) -> NSMutableURLRequest? {
        let request = NSMutableURLRequest(url: NSURL(string: Constants.baseURL + EndPoints.commonEndPoint + "\(movieID)" + EndPoints.finalSimilarEndPoint + Filters.basicFilter)! as URL,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: 10.0)
          initRequest(request: request)
          return request
    }
    
    static func getCreditURL(movieID: Int) -> NSMutableURLRequest? {
        let request = NSMutableURLRequest(url: NSURL(string: Constants.baseURL + EndPoints.commonEndPoint + "\(movieID)" + EndPoints.finalCreditsEndPoint + Filters.basicFilter)! as URL,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: 10.0)
          initRequest(request: request)
          return request
    }
    
    static func getVideoURL(movieID: Int) -> NSMutableURLRequest? {
        let request = NSMutableURLRequest(url: NSURL(string: Constants.baseURL + EndPoints.commonEndPoint + "\(movieID)" + EndPoints.videoFinalEndPoint + Filters.baseFilter)! as URL,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: 10.0)
          initRequest(request: request)
          return request
    }
    
    static func getYoutubeURL(for id: String) -> URL? {
        return URL(string: Constants.youtubeBaseURL + EndPoints.youtubeEndPoint + id + "&key=" + keys.youtubeApiKey)
    }
    
    static func initRequest(request: NSMutableURLRequest) {
        let headers = [
          "accept": "application/json",
          "Authorization": "Bearer \(keys.accessToken)"
        ]
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
    }
    
    static func getImageURL(imageEndPoint: String) -> URL? {
        return URL(string: Constants.imageBaseURL + imageEndPoint)
    }
}
