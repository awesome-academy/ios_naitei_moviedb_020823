import Foundation

class BaseKeys {
    let dict: NSDictionary
    
    init(resourceName: String) {
        guard let filePath = Bundle.main.path(forResource: resourceName, ofType: "plist"),
              let plist = NSDictionary(contentsOfFile: filePath) else { fatalError("Couldn't find file\(resourceName) plist") }
        self.dict = plist
    }
}

protocol APIKeyable {
     var apiKey: String { get }
     var youtubeApiKey: String { get }
     var accessToken: String { get }
}

class ProductKeys: BaseKeys, APIKeyable {
    static let shared = ProductKeys()
    
    private init() {
        super.init(resourceName: "Keys")
    }
    
    var apiKey: String {
        guard let key = dict.object(forKey: "API_KEY") as? String else { return "" }
        return key
    }
    
     var youtubeApiKey: String {
         guard let key = dict.object(forKey: "Youtube_API_KEY") as? String else { return "" }
         return key
    }
    
    var accessToken: String {
        guard let token = dict.object(forKey: "ACCESS_TOKEN") as? String else { return "" }
        return token
   }
}
