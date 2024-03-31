//
//  MainControllerExtension.swift
//  ChoreChampion
//
//  Created by Rhythm Bhandari on 3/30/24.
//

import Foundation
import UIKit

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "choreCell", for: indexPath)
        let item = chores[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = item.title
        content.secondaryText = item.description
        
        cell.contentConfiguration = content
        
        return cell
    }
}
