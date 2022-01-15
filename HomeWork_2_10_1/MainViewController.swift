//
//  ViewController.swift
//  HomeWork_2_10_1
//
//  Created by Aliaksandr Rauko on 14.01.22.
//

import UIKit

enum Link: String {
    case DogImageURL = "https://dog.ceo/api/breeds/image/random"
    case AnimeListURL = "https://api.wazirx.com/api/v2/trades?market=btcusdt"
}

class MainViewController: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDog" {
            let dogVC = segue.destination as! DogImageViewController
            dogVC.fetchDog()
        } else {
            let animeVC = segue.destination as! AnimeTableViewController
            animeVC.fetchAnime()

        }
    }
}

