//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Doğan Ensar Papuçcuoğlu on 7.12.2024.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseURL = "https://api.github.com/users/"
    let cache = NSCache<NSString, UIImage>()
    let decoder = JSONDecoder()
    
    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }
    
//    func getFollowers(for username: String, page: Int, completion: @escaping (Result<[Follower], GFError>) -> Void)  {
//        
//        // Might go further and use url components.
//        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
//        
//        guard let url = URL(string: endpoint) else {
//            completion(.failure(.invalidUsername))
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let _ = error {
//                completion(.failure(.unableToComplete))
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                completion(.failure(.invalidResponse))
//                return
//            }
//            
//            guard let data = data else {
//                completion(.failure(.invalidData))
//                return
//            }
//            
//            do {
//                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                let followers = try decoder.decode([Follower].self, from: data)
//                completion(.success(followers))
//                
//            } catch {
//                completion(.failure(.invalidData))
//            }
//            
//        }
//        task.resume()
//    }
    func getFollowers(for username: String, page: Int) async throws -> [Follower] {
        
        // Might go further and use url components.
        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            throw GFError.invalidUsername
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GFError.invalidResponse
        }
        
        do {
            return try decoder.decode([Follower].self, from: data)
        } catch {
            throw GFError.invalidData
        }
        
        
    }
    
//    func getUserInfo(for username: String, completion: @escaping (Result<User, GFError>)-> Void) {
//        
//        let endpoint = baseURL + "\(username)"
//        
//        guard let url = URL(string: endpoint) else {
//            completion(.failure(.invalidUsername))
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let _ = error {
//                completion(.failure(.unableToComplete))
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                completion(.failure(.invalidResponse))
//                return
//            }
//            
//            guard let data = data else {
//                completion(.failure(.invalidData))
//                return
//            }
//            
//            do {
//                let result = try self.decoder.decode(User.self, from: data)
//                completion(.success(result))
//            } catch {
//                completion(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
    
    func getUserInfo(for username: String) async throws -> User {
        
        let endpoint = baseURL + "\(username)"
        
        guard let url = URL(string: endpoint) else {
            throw GFError.invalidUsername
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GFError.invalidResponse
        }
        
        do {
            return try self.decoder.decode(User.self, from: data)
        } catch {
            throw GFError.invalidData
        }
    }

    
    func downloadImage(from urlString: String) async -> UIImage? {
        
        if let image = cache.object(forKey: urlString as NSString) {
            return image
        }
        
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else {
                return nil
            }
            cache.setObject(image, forKey: urlString as NSString)
            return image
        } catch {
            return nil
        }
    }
    
//    func downloadImage(from urlString: String) async throws -> UIImage? {
//        
//        if let image = cache.object(forKey: urlString as NSString) {
//            completion(image)
//            return
//        }
//        
//        guard let url = URL(string: urlString) else {
//            completion(nil)
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
//            
//            guard let self = self,
//                  error == nil,
//                  let response = response as? HTTPURLResponse, response.statusCode == 200,
//                  let data = data
//            else {
//                completion(nil)
//                return
//            }
//            
//            guard let image = UIImage(data: data) else {
//                completion(nil)
//                return
//            }
//            
//            self.cache.setObject(image, forKey: urlString as NSString)
//            completion(image)
//        }
//        
//        task.resume()
//    }
}
