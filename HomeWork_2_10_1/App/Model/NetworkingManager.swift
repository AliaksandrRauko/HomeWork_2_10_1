//
//  NetworkingManager.swift
//  HomeWork_2_10_1
//
//  Created by Aliaksandr Rauko on 14.01.22.
//

import UIKit

class NetworkingManager {
    static var shared = NetworkingManager()
    private init() {}
    
    func fetchImage(url: String, complition: @escaping(_ image: UIImage) -> Void) {
        guard let url = URL(string: Link.DogImageURL.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            guard let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                complition(image)
            }

        }.resume()
    }

}
