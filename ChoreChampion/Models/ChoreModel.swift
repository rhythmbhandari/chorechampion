//
//  ChoreModel.swift
//  ChoreChampion
//
//  Created by Rhythm Bhandari on 3/30/24.
//

import Foundation
import UIKit

struct Chore {
    let title: String
    let description: String
    let status: TaskStatus
    let annotation: String
}

enum TaskStatus: String, CaseIterable {
    case notStarted = "Not Started"
    case inProgress = "In Progress"
    case completed = "Completed"
    
    var color: UIColor {
            switch self {
            case .notStarted:
                return .white
            case .inProgress:
                return .yellow
            case .completed:
                return .green
            }
        }
}


