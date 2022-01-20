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
    
    
    var dog: Dog!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchImage()
    }
}



// MARK: - Networking
extension DogImageViewController {
    
    //
    //Евгения! подскажи, почему у меня возвращает nil??
    //
    func fetchDog() {
        NetworkingManager.shared.fetchDog(from: Link.dogImageURL.rawValue) { dog in
            self.dog = dog
        }
    }
    
    private func fetchImage() {
        ImageManager.shared.fetchImage(from: dog.message) { result in
            switch result {
            case .success(let data):
                self.imageView.image = UIImage(data: data)
                self.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

