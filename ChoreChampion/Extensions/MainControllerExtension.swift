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
            cell.tintColor = UIColor.secondaryColor

            if let chore = choresManager?.fetchChores()[indexPath.row] {
                cell.configureWithChore(chore)
            }

            tableView.separatorColor = UIColor.primaryColor
            tableView.separatorInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            tableView.separatorStyle = .singleLine

            return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let chore = choresManager?.fetchChores()[indexPath.row]{
            selectedChore = chore
            selectedChoreIndex = indexPath.row
            self.performSegue(withIdentifier: "detailsSegue", sender: self)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
