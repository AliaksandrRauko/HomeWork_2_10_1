//
//  TableViewController.swift
//  HomeWork_2_10_1
//
//  Created by Aliaksandr Rauko on 14.01.22.
//

import UIKit

class CriptTableViewController: UITableViewController {

    private var cripts: [Cript] = []    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cripts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let cript = cripts[indexPath.row]

        var content = cell.defaultContentConfiguration()
        
        content.text = cript.price
        cell.contentConfiguration = content

        return cell
    }

}


// MARK: - Networking
extension CriptTableViewController {
    
    func fetchCript() {
        NetworkingManager.shared.fetchCript(from: Link.criptListURL.rawValue) { cripts in
            self.cripts = cripts
            self.tableView.reloadData()
        }
    }
}
