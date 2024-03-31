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
        print("Total chores \(String(describing: choresManager?.fetchChores().count))")
        return choresManager?.fetchChores().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "choreCell", for: indexPath)
        
        if let chore = choresManager?.fetchChores()[indexPath.row] {
            var content = cell.defaultContentConfiguration()
            content.text = chore.title
            content.secondaryText = chore.description
            
             print("Total chores description\(String(describing: content.secondaryText))")
            cell.contentConfiguration = content
        }
       

        return cell
    }
}
