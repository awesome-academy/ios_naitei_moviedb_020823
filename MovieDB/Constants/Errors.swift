import Foundation

enum APIError: Error {
    case failedToGetData
    case httpRequestFailed(Int)
    case failedToDecodeData
}
