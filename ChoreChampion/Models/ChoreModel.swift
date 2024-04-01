//
//  ChoreModel.swift
//  ChoreChampion
//
//  Created by Rhythm Bhandari on 3/30/24.
//

import Foundation
import UIKit

struct Chore: Codable {
    let title: String
    let description: String
    let status: ChoreStatus
    let annotation: String
}

enum ChoreStatus: Int, Codable {
    case notStarted = 0
    case inProgress = 1
    case completed = 2
    
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
    
    var icon: String {
        switch self {
        case .notStarted:
            return "pause.rectangle.fill"
        case .inProgress:
            return "play.rectangle.fill"
        case .completed:
            return "checkmark.rectangle.fill"
        }
    }
}


