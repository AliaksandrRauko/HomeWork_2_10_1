//
//  ViewController.swift
//  HomeWork_2_10_1
//
//  Created by Aliaksandr Rauko on 14.01.22.
//

import UIKit

enum Link: String {
    case dogImageURL = "https://dog.ceo/api/breeds/image/random"
    case criptListURL = "https://api.wazirx.com/api/v2/trades?market=btcusdt"
}

class MainViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDog" {
            let dogVC = segue.destination as! DogImageViewController
            dogVC.fetchDog()
        } else {
            let criptVC = segue.destination as! CriptTableViewController
            criptVC.fetchCript()
        }
    }
}

