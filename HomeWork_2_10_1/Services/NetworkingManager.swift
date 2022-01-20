//
//  NetworkingManager.swift
//  HomeWork_2_10_1
//
//  Created by Aliaksandr Rauko on 14.01.22.
//

import UIKit

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkingManager {
    static var shared = NetworkingManager()
    private init() {}
    
    func fetchCript(from url: String?, with completion: @escaping([Cript]) -> Void) {
        guard let url = URL(string: url ?? "") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let cript = try JSONDecoder().decode([Cript].self, from: data)
                DispatchQueue.main.async {
                    completion(cript)
                }
            } catch let error {
                print(error)
            }
            
        }.resume()
    }

    func fetchDog(from url: String?, with completion: @escaping(Dog) -> Void) {
        guard let url = URL(string: url ?? "") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let dog = try JSONDecoder().decode(Dog.self, from: data)
                DispatchQueue.main.async {
                    completion(dog)
                }
            } catch let error {
                print(error)
            }
            
        }.resume()
    }
}

class ImageManager {
    
    static var shared = ImageManager()
    private init() {}
    
    func fetchImage(from url: String?, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidURL))
            return
        }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
}
