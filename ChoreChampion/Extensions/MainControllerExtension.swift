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
            var content = cell.defaultContentConfiguration()
            let primaryTextAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont(name: "Helvetica", size: 16) ?? UIFont.systemFont(ofSize: 16), 
                .foregroundColor: UIColor(red: 29/255, green: 36/255, blue: 45/255, alpha: 1)
            ]
            let secondaryTextAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont(name: "Georgia", size: 14) ?? UIFont.systemFont(ofSize: 14),
                .foregroundColor: UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1)
            ]
                    let attributedPrimaryText = NSAttributedString(string: chore.title, attributes: primaryTextAttributes)
                    content.attributedText = attributedPrimaryText
            
        
            var secondaryTextString = "Is a work in progress"
            
            if let assignee = chore.assignee, let date = chore.completionDate {
                let formattedDate = dateFormatter.string(from: date)
                secondaryTextString = assignee.isEmpty ? "Anticipated to complete at \(formattedDate)" : (chore.status == .completed ? "\(assignee) completed this at \(formattedDate)" : "\(assignee) will complete this at \(formattedDate)")
            }

            let attributedSecondaryText = NSAttributedString(string: secondaryTextString, attributes: secondaryTextAttributes)
            content.secondaryAttributedText = attributedSecondaryText

            tableView.separatorColor = UIColor.primaryColor
            tableView.separatorInset = UIEdgeInsets.init(top: 16, left: 16, bottom: 16, right: 16)
            tableView.separatorStyle = .singleLine
            
            content.image = UIImage(systemName: chore.type.icon)
            content.imageProperties.tintColor = chore.status.color
            let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular, scale: .medium)
            content.imageProperties.preferredSymbolConfiguration = symbolConfiguration
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
