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
        return choresManager?.fetchChores().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "choreCell", for: indexPath)
        
        if let chore = choresManager?.fetchChores()[indexPath.row] {
            var content = cell.defaultContentConfiguration()
            content.text = chore.title
            content.secondaryText = chore.description
            cell.contentConfiguration = content
        }
       
        
        return cell
    }
}
