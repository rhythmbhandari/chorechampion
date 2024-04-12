//
//  UITableViewCellExtension.swift
//  ChoreChampion
//
//  Created by Rhythm Bhandari on 4/12/24.
//

import Foundation
import UIKit

extension UITableViewCell {
    func configureWithChore(_ chore: Chore) {
        var content = defaultContentConfiguration()
        
        let primaryTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Helvetica", size: 16) ?? UIFont.systemFont(ofSize: 16),
            .foregroundColor: UIColor(red: 29/255, green: 36/255, blue: 45/255, alpha: 1)
        ]
        let attributedPrimaryText = NSAttributedString(string: chore.title, attributes: primaryTextAttributes)
        content.text = nil
        content.attributedText = attributedPrimaryText

        let secondaryTextString = generateSecondaryText(for: chore)
        let secondaryTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Georgia", size: 14) ?? UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1)
        ]
        let attributedSecondaryText = NSAttributedString(string: secondaryTextString, attributes: secondaryTextAttributes)
        content.secondaryText = nil
        content.secondaryAttributedText = attributedSecondaryText

        content.image = UIImage(systemName: chore.type.icon)
        content.imageProperties.tintColor = chore.status.color
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular, scale: .medium)
        content.imageProperties.preferredSymbolConfiguration = symbolConfiguration

        self.contentConfiguration = content
    }

    private func generateSecondaryText(for chore: Chore) -> String {
        if let assignee = chore.assignee, let date = chore.completionDate {
            let formattedDate = NetworkManager.dateFormatter.string(from: date)
            return assignee.isEmpty ? "Anticipated to complete at \(formattedDate)" :
                (chore.status == .completed ? "\(assignee) completed this at \(formattedDate)" : "\(assignee) will complete this at \(formattedDate)")
        }
        return "Is a work in progress"
    }
}

