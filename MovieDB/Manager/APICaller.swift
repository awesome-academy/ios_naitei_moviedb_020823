import Foundation
import UIKit

class APICaller {
    static let shared = APICaller()
    
    func getData(url: URLRequest, completion: @escaping (Result<[Movie], Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) {data, response, error in
            if let error = error {
                       print("Failed to get Data from URL: \(error)")
                       completion(.failure(APIError.failedToGetData))
                       return
                   }
            guard let data = data, let httpResponse = response as? HTTPURLResponse else {
                print("Failed to get Data from URL: No data or invalid response")
                completion(.failure(APIError.failedToGetData))
                return }
            guard (200...299).contains(httpResponse.statusCode) else {
                print("HTTP request error: \(httpResponse.statusCode)")
                completion(.failure(APIError.httpRequestFailed(httpResponse.statusCode)))
                return }
            do {
                let results = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                print("Failed to decode JSON: \(error)")
                completion(.failure(APIError.failedToDecodeData))
            }
        }
        task.resume()
    }
    
    func getTrendingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URLManager.getURL(for: .trending) else {return}
        getData(url: url as URLRequest, completion: completion)
    }
    
    func getUpcomingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URLManager.getURL(for: .upcoming) else {return}
        getData(url: url as URLRequest, completion: completion)
    }
    
    func getPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URLManager.getURL(for: .popular) else { return }
        getData(url: url as URLRequest, completion: completion)
    }
    
    func getTopRatedMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URLManager.getURL(for: .topRated) else { return }
        getData(url: url as URLRequest, completion: completion)
    }
    
    func getDiscoverMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URLManager.getURL(for: .discover) else {return}
        getData(url: url as URLRequest, completion: completion)
    }
    
    func search( with searchKey: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let query = searchKey.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URLManager.getURL(for: query) else { return }
        getData(url: url as URLRequest, completion: completion)
    }
    
    func getTrailer( with searchKey: String, completion: @escaping (Result<TrailerVideo, Error>) -> Void) {
        guard let query = searchKey.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URLManager.getYoutubeURL(for: query) else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode(YouTubeSearchResponse.self, from: data)
                completion(.success(results.items[0]))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
}
