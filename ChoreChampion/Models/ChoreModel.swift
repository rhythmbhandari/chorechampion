//
//  ChoreModel.swift
//  ChoreChampion
//
//  Created by Rhythm Bhandari on 3/30/24.
//

import Foundation
import UIKit

//struct Chore {
//    let title: String
//    let description: String
//    let status: ChoreStatus
//    let annotation: String
//}

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
                return .white
            case .inProgress:
                return .yellow
            case .completed:
                return .green
            }
        }
}


