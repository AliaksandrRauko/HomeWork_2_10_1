//
//  TableViewController.swift
//  HomeWork_2_10_1
//
//  Created by Aliaksandr Rauko on 14.01.22.
//

import UIKit

class AnimeTableViewController: UITableViewController {

    private var universities: [University] = []

    override func numberOfSections(in tableView: UITableView) -> Int {
        universities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Sell", for: indexPath)

        let university = universities[indexPath.row]

        var content = cell.defaultContentConfiguration()
        
        content.text = university.price
        cell.contentConfiguration = content

        return cell
    }

}


// MARK: - Networking
extension AnimeTableViewController {
    
    func fetchAnime() {
        guard let url = URL(string: Link.AnimeListURL.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            print(response)
            do {
                let JsonDecoder = JSONDecoder()
                self.universities = try JsonDecoder.decode([University].self, from: data)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}
