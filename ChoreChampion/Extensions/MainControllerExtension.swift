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
        cell.tintColor = UIColor.systemTeal
        
        if let chore = choresManager?.fetchChores()[indexPath.row] {
            var content = cell.defaultContentConfiguration()
            content.text = chore.title
            let isCompleted = chore.status == .completed
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            dateFormatter.locale = Locale(identifier: "en_US")

            if let assignee = chore.assignee, let date = chore.completionDate {
                let formattedDate = dateFormatter.string(from: date)
                if(assignee.isEmpty){
                    content.secondaryText = "Anticipated to complete at \(String(describing: formattedDate))"
                }else{
                    if(isCompleted){
                        content.secondaryText = "\(String(describing: assignee)) completed this at \(String(describing: formattedDate))"
                    } else {
                        content.secondaryText = "\(String(describing: assignee)) will complete this at \(String(describing: formattedDate))"
                    }
                }
            }else {
                content.secondaryText = "Is a work in progress"
            }
            
            content.image = UIImage(systemName: chore.type.icon)
            content.imageProperties.tintColor = chore.status.color
            cell.contentConfiguration = content
        }

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
