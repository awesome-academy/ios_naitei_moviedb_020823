import Foundation
import UIKit

class ImageCache {
    static let shared = ImageCache()
    private var cache: NSCache<NSString, UIImage> = NSCache()

    private init() {}

    func getMovieImage(endPoint: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URLManager.getImageURL(imageEndPoint: endPoint) else { return }
        if let cachedImage = cache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
        } else {
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let error = error {
                    print("Error downloading image: \(error.localizedDescription)")
                    completion(nil)
                    return
                }
                if let data = data, let downloadedImage = UIImage(data: data) {
                    self.cache.setObject(downloadedImage, forKey: url.absoluteString as NSString)
                    completion(downloadedImage)
                } else {
                    completion(nil)
                }
            }.resume()
        }
    }
}
