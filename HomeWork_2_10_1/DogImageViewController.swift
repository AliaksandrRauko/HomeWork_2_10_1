//
//  DogImageViewController.swift
//  HomeWork_2_10_1
//
//  Created by Aliaksandr Rauko on 14.01.22.
//

import UIKit

class DogImageViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    private var dog: Dog!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        //        NetworkingManager.shared.fetchImage(url: Link.DogImageURL.rawValue) { image in
        //            self.imageView.image = image
        fetchDog()
        configure(with: dog)
    }
}



// MARK: - Networking
extension DogImageViewController {
    func fetchDog() {
        guard let url = URL(string: Link.DogImageURL.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                self.dog = try JSONDecoder().decode(Dog.self, from: data)
                DispatchQueue.main.async {
//                    self.view.reloadData()
                }
            } catch {
                print(error.localizedDescription)
            }

        }.resume()
        
        DispatchQueue.global().async {
            guard let url = URL(string: self.dog.message ?? "") else { return }
            guard let imageData = try? Data(contentsOf: url) else { return }
            
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: imageData)
            }
        }

    }
    
    func configure(with dog: Dog) {
        
        DispatchQueue.global().async {
            guard let url = URL(string: dog.message ?? "") else { return }
            guard let imageData = try? Data(contentsOf: url) else { return }
            
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: imageData)
            }
        }
    }
}

