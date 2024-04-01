//
//  ChoreModel.swift
//  ChoreChampion
//
//  Created by Rhythm Bhandari on 3/30/24.
//

import Foundation
import UIKit

struct Chore: Codable {
    let id: String
    let title: String
    let status: ChoreStatus
    let type: ChoreType
    let assignee: String?
    let completionDate: Date?
    let detailsAnnotation: String?
}

enum ChoreStatus: Int, Codable {
    case notStarted
    case inProgress
    case completed
    
    var color: UIColor {
        switch self {
        case .notStarted:
            return UIColor(red: 190/255, green: 195/255, blue: 198/255, alpha: 1.0)
        case .inProgress:
            return UIColor(red: 246/255, green: 190/255, blue: 0/255, alpha: 1.0)
        case .completed:
            return UIColor(red: 0/255, green: 135/255, blue: 62/255, alpha: 1.0)
        }
    }
}

enum ChoreType: Int, Codable {
    case authentication
    case list
    case navigation
    case networking
    case persistence
    case meetingPlanning
    case design
    case debugging
    case testing
    case deliverables
    
    var info: String {
        switch self {
        case .authentication:
            return "Tasks related to authenticating a user (i.e. Login Screen)"
        case .list:
            return "The list of tasks (i.e. UITableView)"
        case .navigation:
            return "Navigating to different screens"
        case .networking:
            return "Networking calls and decoding"
        case .persistence:
            return "Saving data locally"
        case .meetingPlanning:
            return "Planning and progress meetings"
        case .design:
            return "General design work"
        case .debugging:
            return "A bug was identified and being worked on"
        case .testing:
            return "Testing features to make sure they are working"
        case .deliverables:
            return "Creating reports and demos for submission"
        }
    }
    
    var icon: String {
        switch self {
        case .authentication:
            return "person.fill"
        case .list:
            return "list.bullet"
        case .navigation:
            return "arrow.right.square.fill"
        case .networking:
            return "network"
        case .persistence:
            return "folder.fill"
        case .meetingPlanning:
            return "calendar"
        case .design:
            return "paintbrush.fill"
        case .debugging:
            return "bug.fill"
        case .testing:
            return "hammer.fill"
        case .deliverables:
            return "doc.plaintext.fill"
        }
    }
}


