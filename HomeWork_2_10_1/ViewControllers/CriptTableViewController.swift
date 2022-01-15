//
//  TableViewController.swift
//  HomeWork_2_10_1
//
//  Created by Aliaksandr Rauko on 14.01.22.
//

import UIKit

class CriptTableViewController: UITableViewController {

    private var cripts: [Cript] = []

    //Евгения!
    //вот сюда заходит и смотрю отладкой, что таблица со значениями, значит json распарсили норм
    override func numberOfSections(in tableView: UITableView) -> Int {
        cripts.count
    }
    
    //Евгения!
    //у меня затык вот здесь, почему-то сюда не заходит приложение и поэтому экран пустой
    //что упускаю?)
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Sell", for: indexPath)

        let cript = cripts[indexPath.row]

        var content = cell.defaultContentConfiguration()
        
        content.text = cript.price
        cell.contentConfiguration = content

        return cell
    }

}


// MARK: - Networking
extension CriptTableViewController {
    
    func fetchAnime() {
        guard let url = URL(string: Link.AnimeListURL.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                self.cripts = try JSONDecoder().decode([Cript].self, from: data)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}
